import 'package:phroneo/features/home/model/match_model.dart';

import '../../ordering/model/option.dart';

class MatchState {
  final bool isLoading;
  final MatchModel? currentMatch;
  final String? currentRoomCode;
  final int? totalPlayers;
  final List<Option> options;
  final bool? isVictory;
  final bool hasProcessedCurrentRound;
  final bool joinSuccess;

  MatchState({
    this.isLoading = false,
    this.currentMatch,
    this.currentRoomCode,
    this.totalPlayers,
    this.options = const [],
    this.isVictory,
    this.hasProcessedCurrentRound = false,
    this.joinSuccess = false
  });

  MatchState copyWith({
    bool? isLoading,
    MatchModel? currentMatch,
    String? currentRoomCode,
    int? totalPlayers,
    List<Option>? options,
    bool? isVictory,
    bool? hasProcessedCurrentRound,
    bool? joinSuccess
  }) {
    return MatchState(
      isLoading: isLoading ?? this.isLoading,
      currentMatch: currentMatch ?? this.currentMatch,
      currentRoomCode: currentRoomCode ?? this.currentRoomCode,
      totalPlayers: totalPlayers ?? this.totalPlayers,
      options: options ?? this.options,
      isVictory: isVictory ?? this.isVictory,
      hasProcessedCurrentRound: hasProcessedCurrentRound ?? this.hasProcessedCurrentRound,
      joinSuccess: joinSuccess ?? this.joinSuccess
    );
  }

  MatchState clearMatch() {
    return MatchState(
      isLoading: isLoading,
      currentMatch: null,
      currentRoomCode: null,
      totalPlayers: totalPlayers,
      options: [],
      isVictory: null,
      hasProcessedCurrentRound: false,
      joinSuccess: false
    );
  }

}