import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:phroneo/core/constants/constants.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/features/home/model/match_model.dart';
import 'package:phroneo/features/home/repository/match_repository.dart';
import 'package:phroneo/features/home/repository/phrase_repository.dart';

import '../../auth/repository/player_repository.dart';
import '../../auth/service/auth_service.dart';

class MatchService {

  final AuthService _authService;
  final MatchRepository _matchRepository;
  final PhraseRepository _phraseRepository;
  final PlayerRepository _playerRepository;

  MatchService({
    required this._authService,
    required this._matchRepository,
    required this._phraseRepository,
    required this._playerRepository
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
    return _matchRepository.streamMatch(roomCode);
  }

  Future<void> updateMatchResult(String roomCode, bool isVictory) async {
    await _matchRepository.updateMatchResult(roomCode, isVictory);
  }

  Future<void> updateStatusMatch(String roomCode, StatusMatch status) async {
    await _matchRepository.updateStatusMatch(roomCode, status);
  }

  Future<void> updateMyPlayerStats(String currentUserId, MatchModel currentMatch) async {
    await _playerRepository.updateMyPlayerStats(currentUserId, currentMatch);
  }

  Future<bool> leaveAndCloseCurrentMatch(String roomCode) async {
    return await _matchRepository.leaveAndCloseCurrentMatch(roomCode);
  }

  Future<String?> createMatch(int selectedPlayers) async {
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

    var matchCreated = await _matchRepository.createMatch(roomCode, newMatch);

    if (!matchCreated) return null;

    return roomCode;
  }

  Future<bool> newRoundMatch(String roomCode, int totalPlayers) async {
    try {

      final user = _authService.currentUser;
      if (user == null) return false;

      final phrase = _phraseRepository.getRandomPhrase();
      final numbers = _generatePlayerNumbers(totalPlayers);

      return await _matchRepository.updateNewMatch(roomCode, phrase, numbers);

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

      return await _matchRepository.joinMatch(roomCode, user.uid);

    } catch (e) {
      if (kDebugMode) {
        print('Erro ao buscar sala: $e');
      }
      return false;
    }
  }

}