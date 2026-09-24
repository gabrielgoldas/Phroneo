import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:phroneo/domain/model/match.dart';
import 'package:phroneo/domain/model/phrase.dart';
import 'package:phroneo/domain/repository/match_repository.dart';

import '../constants/constants.dart';

class MatchRepositoryImpl implements MatchRepository {
  final FirebaseFirestore _firestore;

  MatchRepositoryImpl({
    required this._firestore,
  });

  @override
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
  
  @override
  Future<bool> createMatch(String roomCode, MatchModel newMatch) async {
    try {

      await _firestore
          .collection('matches')
          .doc(roomCode)
          .set(newMatch.toFirestore());
      
      return true;
    } catch(e) {
      if (kDebugMode) print('Erro ao criar partida: $e');
      return false;
    }
  }

  @override
  Future<bool> updateNewMatch(String roomCode, PhraseModel phrase, List<int> numbers) async {
    try {

      await _firestore.collection('matches').doc(roomCode).update({
        'lastRoundVictory': null,
        'currentPhrase': phrase.toMap(),
        'secretNumbers': numbers,
        'status': StatusMatch.playing.name
      });

      return true;

    } catch(e) {
      if (kDebugMode) print('Erro ao atualizar nova partida: $e');
      return false;
    }
  }

  @override
  Future<bool> joinMatch(String roomCode, String userId) async {
    try {

      final docRef = _firestore.collection('matches').doc(roomCode.toUpperCase());
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) return false; // Room don't exists

      final List<String> currentPlayers = List<String>.from(docSnapshot.data()?['playersIds'] ?? []);

      if ( !currentPlayers.contains(userId) ) {
        await docRef.update({
          'playersIds': FieldValue.arrayUnion([ userId ])
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

  @override
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

  @override
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

  @override
  Future<bool> leaveAndCloseCurrentMatch(String roomCode) async {
    try {

      await _firestore.collection('matches').doc(roomCode).update({
        'status': StatusMatch.finished.name,
      });
      return true;

      // TODO -> Race Condition -> Create TTL to Delete directly on Firebase

    } catch (e) {
      if (kDebugMode) {
        print('Erro ao deletar partida atual: $e');
      }
      return false;
    }
  }
}