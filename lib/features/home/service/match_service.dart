import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:phroneo/features/home/model/match_model.dart';
import 'package:phroneo/features/home/model/phrase_model.dart';

import '../../auth/service/auth_service.dart';

class MatchService {

  final AuthService _authService;
  final FirebaseFirestore _firestore;

  MatchService({
    required this._authService,
    required this._firestore
  });

  String _generateRoomCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      6, (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ));
  }

  Future<String?> createMatch(int selectedPlayers) async {
    try {

      final user = _authService.currentUser;
      if (user == null) return null;

      // final roomCode = _generateRoomCode(); TODO -> DESCOMENTAR
      final roomCode = 'LHY9PV';

      final initialPhrase = PhraseModel(
        text: 'O que você levaria para uma ilha deserta?',
        biggestNumber: '100 -> Não pode faltar',
        smallestNumber: '1 -> Desnecessário',
      );

      final newMatch = MatchModel(
          id: roomCode,
          hostId: user.uid,
          playersIds: [ user.uid ],
          maxPlayers: selectedPlayers,
          currentPhrase: initialPhrase,
          secretNumbers: _generatePlayersNumbers(selectedPlayers)
      );

      await _firestore
          .collection('matches')
          .doc(roomCode)
          .set(newMatch.toFirestore());

      return roomCode;
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao criar partida: $e');
      }
      return null;
    }
  }

  Stream<MatchModel?> streamMatch(String roomCode) {
    return _firestore
        .collection('matches')
        .doc(roomCode)
        .snapshots() // O stream original do Firebase
        .map((snapshot) { // O .map transforma o que vem do banco no Model
      if (snapshot.exists) {
        return MatchModel.fromFirestore(snapshot);
      }
      return null; // Caso a sala seja deletada
    });
  }

  List<int> _generatePlayersNumbers(int maxNumberOfPlayers) {
    final random                = Random();
    final int limit             = maxNumberOfPlayers.clamp(1, 100);
    final List<int> allNumbers  = List.generate(100, (index) => index + 1);
    allNumbers.shuffle(random);
    return allNumbers.take(limit).toList();
  }

  Future<bool> joinMatch(String roomCode) async {
    try {

      final user = _authService.currentUser;
      if (user == null) return false;

      final docRef = _firestore.collection('matches').doc(roomCode.toUpperCase());
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) return false; // Room don't exists

      final List<String> currentPlayers = List<String>.from(docSnapshot.data()?['playersIds'] ?? []);

      if ( !currentPlayers.contains(user.uid) ) {
        await docRef.update({
          'playersIds': FieldValue.arrayUnion([ user.uid ])
        });
      }

      return true;

    } catch (e) {
      if (kDebugMode) {
        print('Erro ao buscar sala: $e');
      }
      return false;
    }
  }
}