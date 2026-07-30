import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/constants/constants.dart';
import 'package:phroneo/features/auth/model/player_model.dart';
import 'package:phroneo/features/home/model/match_model.dart';
import 'package:phroneo/features/home/service/match_service.dart';
import 'package:phroneo/features/ordering/model/option.dart';

import '../../../../core/router/app_routes.dart';
import '../../../auth/service/auth_service.dart';

class MatchController extends ChangeNotifier {
  final MatchService _matchService;
  final AuthService _authService;

  bool isLoading = false;
  MatchModel? currentMatch;
  PlayerModel? currentUser;
  String? currentRoomCode;
  int? totalPlayers;
  List<Option> _options = [];
  bool _hasProcessedCurrentRound = false;

  StreamSubscription<MatchModel?>? _matchSubscription;

  MatchController({required this._matchService, required this._authService});

  List<Option> getOptions() => _options;

  bool get isHost {
    final user = _authService.currentUser;
    if (user == null || currentMatch == null) return false;
    return currentMatch!.hostId == user.uid;
  }

  int _getMyIndex() {
    if (currentMatch == null) return -1;

    final user = _authService.currentUser;
    if (user == null) return -1;

    return currentMatch!.playersIds.indexOf(user.uid);
  }

  Future<void> _updateMyPlayerStats(MatchModel match) async {
    final currentMatch  = this.currentMatch;
    final currentUserId = _authService.currentUser?.uid;
    if (currentUserId == null && currentMatch == null) return;
    await _matchService.updateMyPlayerStats(currentUserId!, currentMatch!);
  }

  bool _getResult() {
    for (int i = 0; i < _options.length - 1; i++) {
      // Se o número atual for MENOR que o próximo, a ordem do maior pro menor quebrou
      if (_options[i].number < _options[i + 1].number) {
        return false;
      }
    }

    return true;
  }

  void _initOptions(MatchModel match) {
    if (_options.isNotEmpty) {
      // Pegamos os números que estão na tela agora
      final currentOptionNumbers = _options.map((e) => e.number).toList();

      // Verificamos se eles são os mesmos números que vieram do Firebase agora
      // (Usamos toSet() para ignorar a ordem, já que o host pode ter embaralhado)
      bool isSameRound = currentOptionNumbers.toSet().containsAll(match.secretNumbers.toSet());

      // Se for a mesma rodada, a gente retorna para não estragar a ordenação do Host.
      // Se for FALSA, significa que a rodada mudou! Então o if é ignorado e a lista é recriada lá embaixo.
      if (isSameRound) return;
    }

    final List<int> numbers = match.secretNumbers;
    final List<int> colorsAsInts = match.playerColors;

    final int length = numbers.length < colorsAsInts.length
        ? numbers.length
        : colorsAsInts.length;

    _options = List.generate(
      length,
          (index) =>
          Option(number: numbers[index], color: Color(colorsAsInts[index])),
    );
  }

  void listenToMatch(String roomCode) {
    _matchSubscription?.cancel();
    final normalizedCode = roomCode.toUpperCase();

    _matchSubscription = _matchService.streamMatch(normalizedCode).listen((newMatch) {
      currentMatch = newMatch;

      if (newMatch != null) {
        _initOptions(newMatch);

        if (newMatch.status == StatusMatch.playing || newMatch.status == StatusMatch.lobby) {
          _hasProcessedCurrentRound = false;
        }

        if (newMatch.status == StatusMatch.finished && !_hasProcessedCurrentRound) {
          _hasProcessedCurrentRound = true;
          _updateMyPlayerStats(newMatch);
        }
      }

      notifyListeners();
    });
  }

  Future createMatch(BuildContext context, int selectedPlayers) async {
    isLoading = true;
    notifyListeners();

    totalPlayers = selectedPlayers;

    try {
      currentRoomCode = await _matchService.createMatch(selectedPlayers);

      if (currentRoomCode != null && context.mounted) {
        listenToMatch(currentRoomCode!);
        context.pushNamed(AppRoutes.roomLobby, extra: currentRoomCode);
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Falha ao Criar partida')));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao criar partida: $e');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> joinMatch(String roomCode) async {
    isLoading = true;
    notifyListeners();

    try {
      final joinedRoom = await _matchService.joinMatch(roomCode);
      if (joinedRoom) {
        currentRoomCode = roomCode;
        listenToMatch(roomCode);
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao entrar partida: $e');
      }
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> finishRoundAndSaveResult() async {
    final isVictory = _getResult();

    if (isHost && currentRoomCode != null) {
      try {
        await _matchService.updateMatchResult(currentRoomCode!, isVictory);
      } catch (e) {
        if (kDebugMode) {
          print('Erro ao salvar resultado: $e');
        }
      }
    }

    return isVictory;
  }

  Future<void> startMatch() async {
    if (isHost && currentRoomCode != null) {
      _matchService.updateStatusMatch(currentRoomCode!, StatusMatch.playing);
    }
  }

  Future<bool> leaveAndCloseCurrentMatch() async {
    if (isHost && currentRoomCode != null) {
      return await _matchService.leaveAndCloseCurrentMatch(currentRoomCode!);
    }
    return false;
  }

  Future<bool> newRoundMatch() async {
    if (isHost && currentRoomCode != null && totalPlayers != null) {
      return await _matchService.newRoundMatch(currentRoomCode!, totalPlayers!);
    }
    return false;
  }

  void leaveMatch() {
    _matchSubscription?.cancel();
    currentMatch = null;
    currentRoomCode = null;
    _options = [];
    notifyListeners();
  }

  int getSecretNumber() {
    final myIndex = _getMyIndex();

    if (myIndex != -1 && currentMatch!.secretNumbers.isNotEmpty) {
      if (myIndex < currentMatch!.secretNumbers.length) {
        return currentMatch!.secretNumbers[myIndex];
      }
    }

    return 0;
  }

  int getMyColor() {
    final myIndex = _getMyIndex();

    if (myIndex != -1 && currentMatch!.playerColors.isNotEmpty) {
      if (myIndex < currentMatch!.playerColors.length) {
        return currentMatch!.playerColors[myIndex];
      }
    }

    return 0;
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final Option item = _options.removeAt(oldIndex);
    _options.insert(newIndex, item);

    notifyListeners();
  }

  bool allPlayersJoinMatch() {
    final currentMatch = this.currentMatch;

    if (currentMatch != null) {
      final totalPlayersJoined = currentMatch.playersIds.length;
      final maxPlayersLimit = currentMatch.maxPlayers;

      if (totalPlayersJoined == maxPlayersLimit) return true;
    }

    return false;
  }

}