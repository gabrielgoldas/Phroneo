import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:phroneo/core/model/match_model.dart';
import 'package:phroneo/core/model/phrase_model.dart';

import '../../auth/service/auth_service.dart';

class MatchService {

  final AuthService _authService;
  final FirebaseFirestore _firestore;
  MatchModel? currentMatch;

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

      final roomCode = _generateRoomCode();

      final initialPhrase = PhraseModel(
        text: 'O que você levaria para uma ilha deserta?',
        biggestNumber: '100 -> Não pode faltar',
        smallestNumber: '1 -> Desnecessário',
      );

      final newMatch = MatchModel(
          id: roomCode,
          hostId: user.uid,
          playersIds: [ user.uid ],
          numberOfPlayers: selectedPlayers,
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

  int? getSecretNumber(String roomCode) {
    final user = _authService.currentUser;
    if (user == null) return null;

    if ( currentMatch != null) {
      final index = currentMatch!.playersIds.indexOf(user.uid);
      if (index == -1) return 0;
      return currentMatch!.secretNumbers[index];
    }
    return null;
  }

  Future<int?> getCurrentPhrase(String roomCode) async {
    final user = _authService.currentUser;
    if (user == null) return null;

    if ( currentMatch != null) {
      final index = currentMatch!.playersIds.indexOf(user.uid);
      if (index == -1) return 0;
      return currentMatch!.secretNumbers[index];
    }
    return null;
  }

  List<int> _generatePlayersNumbers(int maxNumberOfPlayers) {
    final random = Random();

    return List.generate(
      maxNumberOfPlayers,
          (_) => random.nextInt(100) + 1,
    );
  }

  Future<bool> joinMatch(String roomCode) async {
    try {

      final user = _authService.currentUser;
      if (user == null) return false;

      final docRef = _firestore.collection('matches').doc(roomCode.toUpperCase());
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) return false; // Room don't exists

      currentMatch = MatchModel.fromFirestore(docSnapshot);

      final List<String> currentPlayers = List<String>.from(docSnapshot.data()?['playersIds'] ?? []);

      if ( !currentPlayers.contains(user.uid) ) {
        await docRef.update({
          'playersIds': FieldValue.arrayUnion([ user.uid ]),
          'numberOfPlayers': FieldValue.increment(1),
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