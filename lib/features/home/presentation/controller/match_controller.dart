import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/model/match_model.dart';
import 'package:phroneo/features/home/service/match_service.dart';

import '../../../../core/router/app_routes.dart';
import '../../../auth/service/auth_service.dart';

class MatchController extends ChangeNotifier {
  final MatchService _matchService;
  final AuthService _authService;

  bool isLoading = false;
  MatchModel? currentMatch;
  String? currentRoomCode;

  StreamSubscription<MatchModel?>? _matchSubscription;

  MatchController({
    required this._matchService,
    required this._authService
  });

  void listenToMatch(String roomCode) {
    _matchSubscription?.cancel();
    final normalizedCode = roomCode.toUpperCase();

    _matchSubscription =
        _matchService.streamMatch(normalizedCode).listen((newMatch) {
              currentMatch = newMatch;
              print('🔄 O Stream atualizou! Nova lista de players: ${newMatch?.playersIds}');
              notifyListeners();
            });
  }

  void leaveMatch() {
    _matchSubscription?.cancel();
    currentMatch = null;
    currentRoomCode = null;
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
    if (currentMatch == null) return 0;

    final user = _authService.currentUser; // Ou pegando do _authService injetado no controller
    if (user == null) return 0;

    final myIndex = currentMatch!.playersIds.indexOf(user.uid);

    if (myIndex != -1 && currentMatch!.secretNumbers.isNotEmpty) {
      if (myIndex < currentMatch!.secretNumbers.length) {
        return currentMatch!.secretNumbers[myIndex];
      }
    }

    return 0;
  }
}
