import 'package:phroneo/domain/model/match.dart';
import 'package:phroneo/domain/model/phrase.dart';

import '../../data/constants/constants.dart';

abstract class MatchRepository {

  Stream<MatchModel?> streamMatch(String roomCode);
  
  Future<bool> createMatch(String roomCode, MatchModel newMatch);

  Future<bool> updateNewMatch(String roomCode, PhraseModel phrase, List<int> numbers);

  Future<bool> joinMatch(String roomCode, String userId);

  Future<void> updateMatchResult(String roomCode, bool isVictory);

  Future<void> updateStatusMatch(String roomCode, StatusMatch status);

  Future<bool> leaveAndCloseCurrentMatch(String roomCode);
}