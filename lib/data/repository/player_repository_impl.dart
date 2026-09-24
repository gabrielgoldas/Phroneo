import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:phroneo/domain/repository/player_repository.dart';

import '../../domain/model/match.dart';
import '../model/player.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final FirebaseFirestore _firestore;

  PlayerRepositoryImpl({ required this._firestore });

  @override
  Future<void> saveNewPlayerToFirestore(User user) async {
    final newPlayer = PlayerModel(
      name: user.displayName ?? 'Jogador Misterioso',
      photoUrl: user.photoURL ?? '',
    );

    try {
      await _firestore
          .collection('players')
          .doc(user.uid)
          .set(newPlayer.toFirestore());

    } catch (e) {
      if (kDebugMode) print('Erro ao salvar jogador no Firestore: $e');
    }
  }

  @override
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

}