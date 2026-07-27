import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phroneo/core/constants.dart';
import 'package:phroneo/core/model/phrase_model.dart';

class MatchModel {
  final String id; // used to QR Code
  final String hostId;
  final List<String> playersIds;
  final int numberOfPlayers;
  final PhraseModel currentPhrase;
  final int wins;
  final int defeats;
  final StatusMatch status; // lobby, playing, finished


  MatchModel({
    required this.id,
    required this.hostId,
    required this.playersIds,
    required this.numberOfPlayers,
    required this.currentPhrase,
    this.wins = 0,
    this.defeats = 0,
    this.status = StatusMatch.lobby
  });

  Map<String, dynamic> toFirestore() {
    return {
      'hostId': hostId,
      'playersIds': playersIds,
      'numberOfPlayers': numberOfPlayers,
      'currentPhrase': currentPhrase.toMap(),
      'wins': wins,
      'defeats': defeats,
      'status': status.name,
    };
  }

  factory MatchModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;

    // Converte a String do banco de volta para o Enum correspondente
    StatusMatch getStatus(String statusStr) {
      return StatusMatch.values.firstWhere(
            (e) => e.name == statusStr,
        orElse: () => StatusMatch.lobby, // Fallback de segurança
      );
    }

    return MatchModel(
      id: snapshot.id, // O ID é o código da sala
      hostId: data['hostId'] ?? '',
      // List<dynamic> vindo do Firebase precisa de cast para List<String>
      playersIds: List<String>.from(data['playersIds'] ?? []),
      numberOfPlayers: data['numberOfPlayers'] ?? 1,
      currentPhrase: PhraseModel.fromMap(data['currentPhrase'] ?? {}),
      wins: data['wins'] ?? 0,
      defeats: data['defeats'] ?? 0,
      status: getStatus(data['status'] ?? 'lobby'),
    );
  }
}