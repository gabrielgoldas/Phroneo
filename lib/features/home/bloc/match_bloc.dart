import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phroneo/features/auth/service/auth_service.dart';
import 'package:phroneo/features/home/bloc/match_event.dart';
import 'package:phroneo/features/home/bloc/match_state.dart';
import 'package:phroneo/features/home/service/match_service.dart';

import '../../../core/constants/constants.dart';
import '../../ordering/model/option.dart';
import '../model/match_model.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final MatchService _matchService;
  final AuthService _authService;

  StreamSubscription<MatchModel?>? _matchSubscription;

  MatchBloc({
    required this._matchService,
    required this._authService
  }) : super(MatchState()) {

    on<CreateMatch>(_onCreateMatch);
    on<JoinMatch>(_onJoinMatch);
    on<ListenMatch>(_onListenMatch);
    on<MatchUpdated>(_onMatchUpdated);
    on<ReorderOption>(_onReorderOption);
    on<StartMatch>(_onStartMatch);
    on<FinishMatch>(_onFinishMatch);
    on<NewRound>(_onNewRound);
    on<LeaveMatch>(_onLeaveMatch); // é usado?
    on<LeaveAndCloseMatch>(_onLeaveAndCloseMatch);

  }

  bool get isHost {
    final user = _authService.currentUser;
    final match = state.currentMatch;

    if (user == null || match == null) return false;
    return match.hostId == user.uid;
  }

  bool get allPlayersJoinMatch {
    final match = state.currentMatch;

    if (match == null) return false;

    return match.playersIds.length == match.maxPlayers;
  }

  @override
  Future<void> close() async {
    await _matchSubscription?.cancel();
    return super.close();
  }

  int _getMyIndex() {
    if (state.currentMatch == null) return -1;

    final user = _authService.currentUser;
    if (user == null) return -1;

    return state.currentMatch!.playersIds.indexOf(user.uid);
  }



  int getSecretNumber() {
    final myIndex = _getMyIndex();

    if (myIndex != -1 && state.currentMatch!.secretNumbers.isNotEmpty) {
      if (myIndex < state.currentMatch!.secretNumbers.length) {
        return state.currentMatch!.secretNumbers[myIndex];
      }
    }

    return 0;
  }

  int getMyColor() {
    final myIndex = _getMyIndex();

    if (myIndex != -1 && state.currentMatch!.playerColors.isNotEmpty) {
      if (myIndex < state.currentMatch!.playerColors.length) {
        return state.currentMatch!.playerColors[myIndex];
      }
    }

    return 0;
  }

  Future<void> _onCreateMatch(CreateMatch event, Emitter<MatchState> emit) async {
    emit(state.copyWith(
      isLoading: true,
      totalPlayers: event.selectedPlayers
    ));

    try {

      final roomCode = await _matchService.createMatch(event.selectedPlayers);

      if (roomCode == null) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      emit(state.copyWith(
        isLoading: false,
        currentRoomCode: roomCode
      ));

      add(ListenMatch(roomCode));

    } catch (e) {
      emit(state.copyWith( isLoading: false ));
    }
  }

  Future<void> _onJoinMatch(JoinMatch event, Emitter<MatchState> emit) async {

    emit(state.copyWith(isLoading: true));

    try {
      final joinedRoom = await _matchService.joinMatch(event.roomCode);

      if (!joinedRoom) {
        emit(state.copyWith( isLoading: false, joinSuccess: false ));
        return;
      }

      emit(state.copyWith(
        isLoading: false,
        joinSuccess: true,
        currentRoomCode: event.roomCode,
      ));

      add(ListenMatch(event.roomCode));

    } catch (e) {
      if (kDebugMode) print('Erro ao entrar partida: $e');
      emit(state.copyWith( isLoading: false, joinSuccess: false ));
    }
  }

  Future<void> _onListenMatch(ListenMatch event, Emitter<MatchState> emit) async {
    await _matchSubscription?.cancel();

    final normalizedCode = event.roomCode.toUpperCase();

    _matchSubscription = _matchService
        .streamMatch(normalizedCode)
        .listen((newMatch) {
          add(MatchUpdated(newMatch));
        });
  }

  Future<void> _onMatchUpdated(MatchUpdated event, Emitter<MatchState> emit) async {
    final newMatch = event.match;

    if (newMatch == null) {
      emit(state.copyWith( currentMatch: null, options: [] ));
      return;
    }

    final options = _initOptions( newMatch, state.options );

    var hasProcessedCurrentRound = state.hasProcessedCurrentRound;

    if (newMatch.status == StatusMatch.playing || newMatch.status == StatusMatch.lobby) {
      hasProcessedCurrentRound = false;
    }

    if (newMatch.status == StatusMatch.finished && !hasProcessedCurrentRound) {
      hasProcessedCurrentRound = true;
      await _updateMyPlayerStats(newMatch);
    }

    emit(state.copyWith(
      currentMatch: newMatch,
      options: options,
      hasProcessedCurrentRound: hasProcessedCurrentRound
    ));

  }

  Future<void> _onReorderOption(ReorderOption event, Emitter<MatchState> emit) async {
    var newIndex = event.newIndex;
    if (event.oldIndex < newIndex) {
      newIndex -= 1;
    }

    final options = List<Option>.from(state.options);

    final item = options.removeAt(event.oldIndex);
    options.insert(newIndex, item);

    emit(state.copyWith( options: options ));
  }

  Future<void> _onStartMatch(StartMatch event, Emitter<MatchState> emit) async {
    if (!isHost || state.currentRoomCode == null) return;
    await _matchService.updateStatusMatch(state.currentRoomCode!, StatusMatch.playing);
  }

  Future<void> _onFinishMatch(FinishMatch event, Emitter<MatchState> emit) async {
    final isVictory = _getResult();

    if (isHost && state.currentRoomCode != null) {
      try {
        await _matchService.updateMatchResult(state.currentRoomCode!, isVictory);
      } catch (e) {
        if (kDebugMode) {
          print('Erro ao salvar resultado: $e');
        }
      }
    }

    emit(state.copyWith( isVictory: isVictory ));
  }

  Future<void> _onNewRound(NewRound event, Emitter<MatchState> emit) async {
    if (isHost && state.currentRoomCode != null && state.totalPlayers != null) {
      await _matchService.newRoundMatch(state.currentRoomCode!, state.totalPlayers!);
    }
  }

  Future<void> _onLeaveMatch(LeaveMatch event, Emitter<MatchState> emit) async {
    await _matchSubscription?.cancel();
    emit( state.clearMatch() );
  }

  Future<void> _onLeaveAndCloseMatch(LeaveAndCloseMatch event, Emitter<MatchState> emit) async {
    if (!isHost && state.currentRoomCode == null) return;
     await _matchService.leaveAndCloseCurrentMatch(state.currentRoomCode!);
  }

  List<Option> _initOptions(MatchModel match, List<Option> currentOptions) {
    if (currentOptions.isNotEmpty) {
      final currentNumbers = currentOptions.map((e) => e.number).toList();

      bool isSameRound = currentNumbers.toSet().containsAll(match.secretNumbers.toSet());

      if (isSameRound) return currentOptions;
    }

    final numbers = match.secretNumbers;
    final colors = match.playerColors;

    final int length = numbers.length < colors.length
        ? numbers.length
        : colors.length;

    return List.generate(
      length,
          (index) =>
          Option(number: numbers[index], color: Color(colors[index])),
    );
  }

  bool _getResult() {
    final options = List<Option>.from(state.options);
    for (int i = 0; i < options.length - 1; i++) {
      // Se o número atual for MENOR que o próximo, a ordem do maior pro menor quebrou
      if (options[i].number < options[i + 1].number) {
        return false;
      }
    }

    return true;
  }

  Future<void> _updateMyPlayerStats(MatchModel match) async {
    final userId = _authService.currentUser?.uid;
    if (userId == null) return;
    await _matchService.updateMyPlayerStats(userId, match);
  }

}