import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../home/model/match_model.dart';
import '../model/player_model.dart';

class PlayerRepository {
  final FirebaseFirestore _firestore;

  PlayerRepository({ required this._firestore });

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