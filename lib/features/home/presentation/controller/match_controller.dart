import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/model/match_model.dart';
import 'package:phroneo/features/home/service/match_service.dart';

import '../../../../core/router/app_routes.dart';

class MatchController extends ChangeNotifier {
  final MatchService _matchService;
  bool isLoading = false;
  MatchModel? currentMatch;
  String? currentRoomCode;
  StreamSubscription<DocumentSnapshot>? _matchSubscription;

  MatchController({required this._matchService});

  void listenToMatch(String roomCode) {
    _matchSubscription?.cancel();

    _matchSubscription =
        _matchService.streamMatch(roomCode).listen((newMatch) {
              currentMatch = newMatch;
              notifyListeners();
            })
            as StreamSubscription<DocumentSnapshot<Object?>>?;
  }

  void leaveMatch() {
    _matchSubscription?.cancel();
    currentMatch = null;
    notifyListeners();
  }

  Future createMatch(BuildContext context, int selectedPlayers) async {
    isLoading = true;
    notifyListeners();

    try {
      currentRoomCode = await _matchService.createMatch(selectedPlayers);

      if (currentRoomCode != null) {
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
      if (joinedRoom) context.pushNamed(AppRoutes.game);
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao entrar partida: $e');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  int? getSecretNumber() {
    isLoading = true;
    notifyListeners();
    if (currentRoomCode == null ) return null;
    final myNumber = _matchService.getSecretNumber(currentRoomCode!);
    if (myNumber != null) {
      isLoading = false;
      notifyListeners();
      return myNumber;
    } else {
      isLoading = false;
      notifyListeners();
      return 0;
    }
  }
}
