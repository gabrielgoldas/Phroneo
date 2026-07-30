import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:phroneo/core/constants/constants.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/features/home/model/match_model.dart';
import 'package:phroneo/features/home/model/phrase_model.dart';
import 'package:phroneo/features/home/repository/phrase_repository.dart';

import '../../auth/service/auth_service.dart';

class MatchService {

  final AuthService _authService;
  final FirebaseFirestore _firestore;
  final PhraseRepository _phraseRepository;

  MatchService({
    required this._authService,
    required this._firestore,
    required this._phraseRepository
  });

  String _generateRoomCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return String.fromCharCodes(Iterable.generate(
      6, (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ));
  }

  List<int> _generatePlayerNumbers(int maxNumberOfPlayers) {
    final random                = Random();
    final int limit             = maxNumberOfPlayers.clamp(1, 100);
    final List<int> allNumbers  = List.generate(100, (index) => index + 1);
    allNumbers.shuffle(random);
    return allNumbers.take(limit).toList();
  }

  List<int> _getPlayerColors(int maxNumberOfPlayers) {
    final random = Random();
    final listCopy = List<int>.from(AppColors.playerPaletteValues);
    listCopy.shuffle(random);
    final limit = maxNumberOfPlayers.clamp(1, listCopy.length);
    return listCopy.take(limit).toList();
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

  Future<String?> createMatch(int selectedPlayers) async {
    try {

      final user = _authService.currentUser;
      if (user == null) return null;

      final roomCode = _generateRoomCode();
      final initialPhrase = _phraseRepository.getRandomPhrase();

      final newMatch = MatchModel(
          id: roomCode,
          hostId: user.uid,
          playersIds: [ user.uid ],
          maxPlayers: selectedPlayers,
          currentPhrase: initialPhrase,
          secretNumbers: _generatePlayerNumbers(selectedPlayers), 
          playerColors: _getPlayerColors(selectedPlayers)
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

  Future<bool> newRoundMatch(String roomCode, int totalPlayers) async {
    try {

      final user = _authService.currentUser;
      if (user == null) return false;

      final phrase = _phraseRepository.getRandomPhrase();

      await _firestore.collection('matches').doc(roomCode).update({
        'lastRoundVictory': null,
        'currentPhrase': phrase.toMap(),
        'secretNumbers': _generatePlayerNumbers(totalPlayers),
        'status': StatusMatch.playing.name
      });

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao criar partida: $e');
      }
      return false;
    }
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

  Future<void> updateMatchResult(String roomCode, bool isVictory) async {
    try {

      await _firestore.collection('matches').doc(roomCode).update({
        'status': StatusMatch.finishedRound.name,
        'lastRoundVictory': isVictory,
        if (isVictory) 'wins': FieldValue.increment(1) else 'defeats': FieldValue.increment(1)
      });

    } catch (e) {
      if (kDebugMode) {
        print('Erro ao atualizar partida: $e');
      }
    }
  }

  Future<void> updateStatusMatch(String roomCode, StatusMatch status) async {
    try {

      await _firestore.collection('matches').doc(roomCode).update({
        'status': status.name,
      });

    } catch (e) {
      if (kDebugMode) {
        print('Erro ao atualizar partida: $e');
      }
    }
  }

  Future<void> updateMyPlayerStats(String currentUserId, MatchModel currentMatch) async {
    try {
      await _firestore.collection('players').doc(currentUserId).update({
        'wins': FieldValue.increment(currentMatch.wins),
        'defeats': FieldValue.increment(currentMatch.defeats),
      });
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao atualizar estatísticas do jogador: $e');
      }
    }
  }

  Future<bool> leaveAndCloseCurrentMatch(String roomCode) async {
    try {

      await _firestore.collection('matches').doc(roomCode).update({
        'status': StatusMatch.finished.name,
      });
      return true;

      // TODO -> Race Condition -> Create TTL to Delete directly on Firebase
      // await _firestore.collection('matches').doc(roomCode).delete();

    } catch (e) {
      if (kDebugMode) {
        print('Erro ao deletar partida atual: $e');
      }
      return false;
    }
  }

}