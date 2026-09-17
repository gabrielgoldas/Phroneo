import '../model/match_model.dart';

sealed class MatchEvent {}

class CreateMatch extends MatchEvent {
  final int selectedPlayers;

  CreateMatch(this.selectedPlayers);
}

class JoinMatch extends MatchEvent {
  final String roomCode;

  JoinMatch(this.roomCode);
}

class ListenMatch extends MatchEvent {
  final String roomCode;

  ListenMatch(this.roomCode);
}

class ReorderOption extends MatchEvent {
  final int oldIndex;
  final int newIndex;

  ReorderOption(this.oldIndex, this.newIndex);
}

class MatchUpdated extends MatchEvent {
  final MatchModel? match;

  MatchUpdated(this.match);
}

class StartMatch extends MatchEvent {}

class FinishMatch extends MatchEvent {}

class NewRound extends MatchEvent {}

class LeaveMatch extends MatchEvent {}

class LeaveAndCloseMatch extends MatchEvent {}