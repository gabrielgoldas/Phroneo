import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/constants.dart';
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
  List<Option> _options = [];

  StreamSubscription<MatchModel?>? _matchSubscription;

  MatchController({required this._matchService, required this._authService});

  void listenToMatch(String roomCode) {
    _matchSubscription?.cancel();
    final normalizedCode = roomCode.toUpperCase();

    _matchSubscription = _matchService.streamMatch(normalizedCode).listen((newMatch) {
      currentMatch = newMatch;

      if (newMatch != null) {
        _initOptions(newMatch);
      }

      notifyListeners();
    });
  }

  // Método auxiliar para criar as opções apenas quando necessário
  void _initOptions(MatchModel match) {
    // Se a lista de options já tem o mesmo tamanho, não sobrescrevemos
    // para não perder a ordem que o usuário já arrastou!
    if (_options.isNotEmpty) {
      return;
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

  void leaveMatch() {
    _matchSubscription?.cancel();
    currentMatch = null;
    currentRoomCode = null;
    _options = [];
    notifyListeners();
  }

  Future createMatch(BuildContext context, int selectedPlayers) async {
    isLoading = true;
    notifyListeners();

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

  Future joinMatch(BuildContext context, String roomCode) async {
    isLoading = true;
    notifyListeners();

    try {
      final joinedRoom = await _matchService.joinMatch(roomCode);
      if (joinedRoom && context.mounted) {
        currentRoomCode = roomCode;
        // Abre o túnel do Firebase ANTES de ir para a tela do jogo!
        listenToMatch(roomCode);
        context.pushNamed(AppRoutes.game);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao entrar partida: $e');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
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

  int _getMyIndex() {
    if (currentMatch == null) return -1;

    final user = _authService
        .currentUser; // Ou pegando do _authService injetado no controller
    if (user == null) return -1;

    return currentMatch!.playersIds.indexOf(user.uid);
  }

  // 3. O getter agora só entrega a lista 'viva' salva no controller
  List<Option> getOptions() => _options;

  // 4. O reordenador agora altera diretamente a lista 'viva'!
  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final Option item = _options.removeAt(oldIndex);
    _options.insert(newIndex, item);

    notifyListeners(); // O ListenableBuilder vai re-renderizar a lista na nova ordem!
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

  bool get isHost {
    final user = _authService.currentUser;
    if (user == null || currentMatch == null) return false;
    return currentMatch!.hostId == user.uid;
  }

  bool getResult() {
    for (int i = 0; i < _options.length - 1; i++) {
      // Se o número atual for MENOR que o próximo, a ordem do maior pro menor quebrou
      if (_options[i].number < _options[i + 1].number) {

        return false;
      }
    }

    return true;
  }

  Future<bool> finishRoundAndSaveResult() async {
    final isVictory = getResult();

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

}
