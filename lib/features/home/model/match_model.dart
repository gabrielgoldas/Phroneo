import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phroneo/core/constants/constants.dart';
import 'package:phroneo/features/home/model/phrase_model.dart';

class MatchModel {
  final String id; // used to QR Code
  final String hostId;
  final List<String> playersIds;
  final int maxPlayers;
  final PhraseModel currentPhrase;
  final List<int> secretNumbers;
  final List<int> playerColors;
  final int wins;
  final int defeats;
  final StatusMatch status;
  final bool? lastRoundVictory;


  MatchModel({
    required this.id,
    required this.hostId,
    required this.playersIds,
    required this.maxPlayers,
    required this.currentPhrase,
    required this.secretNumbers,
    required this.playerColors,
    this.wins = 0,
    this.defeats = 0,
    this.status = StatusMatch.lobby,
    this.lastRoundVictory
  });

  Map<String, dynamic> toFirestore() {
    return {
      'hostId': hostId,
      'playersIds': playersIds,
      'numberOfPlayers': maxPlayers,
      'currentPhrase': currentPhrase.toMap(),
      'secretNumbers': secretNumbers,
      'playerColors': playerColors,
      'wins': wins,
      'defeats': defeats,
      'status': status.name,
      'lastRoundVictory': lastRoundVictory,
    };
  }

  factory MatchModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;

    StatusMatch getStatus(String statusStr) {
      return StatusMatch.values.firstWhere(
            (e) => e.name == statusStr,
        orElse: () => StatusMatch.lobby,
      );
    }

    return MatchModel(
      id: snapshot.id,
      hostId: data['hostId'] ?? '',
      playersIds: List<String>.from(data['playersIds'] ?? []),
      maxPlayers: data['numberOfPlayers'] ?? 1,
      currentPhrase: PhraseModel.fromMap(data['currentPhrase'] ?? {}),
      secretNumbers: List<int>.from(data['secretNumbers'] ?? []),
      playerColors: List<int>.from(data['playerColors'] ?? []),
      wins: data['wins'] ?? 0,
      defeats: data['defeats'] ?? 0,
      status: getStatus(data['status'] ?? 'lobby'),
      lastRoundVictory: data['lastRoundVictory'],
    );
  }
}