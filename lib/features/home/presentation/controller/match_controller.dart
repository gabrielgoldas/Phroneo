import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/features/home/service/match_service.dart';

import '../../../../core/router/app_routes.dart';

class MatchController extends ChangeNotifier {

  final MatchService _matchService;
  bool isLoading = false;

  MatchController({ required this._matchService }) ;

  Future createMatch(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {

      final matchUid = await _matchService.createMatch();

      if ( matchUid != null ) {
        context.pushNamed(AppRoutes.roomLobby);
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Falha ao Criar partida')),
        );
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
}