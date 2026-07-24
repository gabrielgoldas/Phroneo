import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerModel {
  final String? id;
  final String name;
  final String photoUrl;
  final int wins;
  final int matchesPlayed;

  PlayerModel({
    this.id,
    required this.name,
    required this.photoUrl,
    this.wins = 0,
    this.matchesPlayed = 0,
  });

  factory PlayerModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, [SnapshotOptions? options]) {
    final data = snapshot.data();
    return PlayerModel(
        id: snapshot.id,
        name: data?['name'] ?? 'Anônimo',
        photoUrl: data?['photoUrl'] ?? '',
        wins: data?['wins'] ?? 0,
        matchesPlayed: data?['matchesPlayed'] ?? 0
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'photoUrl': photoUrl,
      'wins': wins,
      'matchesPlayed': matchesPlayed,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}