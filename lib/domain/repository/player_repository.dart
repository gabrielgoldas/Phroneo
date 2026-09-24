import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/model/match.dart';

abstract class PlayerRepository {
  Future<void> saveNewPlayerToFirestore(User user);

  Future<void> updateMyPlayerStats(
    String currentUserId,
    MatchModel currentMatch,
  );
}
