import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:phroneo/core/model/match_model.dart';
import 'package:phroneo/core/model/phrase_model.dart';

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

  Future<String?> createMatch() async {
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
          numberOfPlayers: 1,
          currentPhrase: initialPhrase
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
}