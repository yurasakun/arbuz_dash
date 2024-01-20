import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leaderboard_repository/leaderboard_repository.dart';

/// {@template leaderboard_repository}
/// Repository to access leaderboard data in Firebase Cloud Firestore.
/// {@endtemplate}
class LeaderboardRepository {
  /// {@macro leaderboard_repository}
  const LeaderboardRepository(
    FirebaseFirestore firebaseFirestore,
  ) : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  static const _leaderboardLimit = 10;
  static const _leaderboardCollectionName = 'leaderboard';
  static const _scoreFieldName = 'score';

  /// Acquires top 10 [LeaderboardEntryData]s.
  Future<List<LeaderboardEntryData>> fetchTop10Leaderboard() async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection(_leaderboardCollectionName)
          .orderBy(_scoreFieldName, descending: true)
          .limit(_leaderboardLimit)
          .get();
      final documents = querySnapshot.docs;
      return documents.toLeaderboard();
    } on LeaderboardDeserializationException {
      rethrow;
    } on Exception catch (error, stackTrace) {
      throw FetchTop10LeaderboardException(error, stackTrace);
    }
  }

  /// Adds player's score entry to the leaderboard if it is within the top-10
  Future<void> addLeaderboardEntry(
      LeaderboardEntryData entry, String id) async {
    final leaderboard = await _fetchLeaderboardSortedByScore();
    if (leaderboard.length < 10) {
      await _saveScore(entry, id);
    } else {
      final tenthPositionScore = leaderboard[9].score;
      if (entry.score > tenthPositionScore) {
        await _saveScore(entry, id);
      }
    }
  }

  Future<List<LeaderboardEntryData>> _fetchLeaderboardSortedByScore() async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection(_leaderboardCollectionName)
          .orderBy(_scoreFieldName, descending: true)
          .get();
      final documents = querySnapshot.docs;
      return documents.toLeaderboard();
    } on Exception catch (error, stackTrace) {
      throw FetchLeaderboardException(error, stackTrace);
    }
  }

  Future<void> _saveScore(LeaderboardEntryData entry, String id) async {
    try {
      final leaderboardEntryData = await _getLeaderboardEntryData(id);

      if (leaderboardEntryData != null) {
         return await _updateLeaderboardEntryData(entry, id);
      }else{
        return await _firebaseFirestore
            .collection(_leaderboardCollectionName)
            .doc(id)
            .set(entry.toJson());
      }
    } on Exception catch (error, stackTrace) {
      throw AddLeaderboardEntryException(error, stackTrace);
    }
  }

  Future<LeaderboardEntryData?> _getLeaderboardEntryData(String userId) async {
    final snapshot = await _firebaseFirestore
        .collection(_leaderboardCollectionName)
        .doc(userId)
        .get();
    if (snapshot.exists) {
      return LeaderboardEntryData.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }

  Future<void> _updateLeaderboardEntryData(
    LeaderboardEntryData entryData,
    String id,
  ) async {
    try {
      await _firebaseFirestore
          .collection(_leaderboardCollectionName)
          .doc(id)
          .update(entryData.toJson());
    } catch (e) {}
  }
}

extension on List<QueryDocumentSnapshot> {
  List<LeaderboardEntryData> toLeaderboard() {
    final leaderboardEntries = <LeaderboardEntryData>[];
    for (final document in this) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        try {
          leaderboardEntries.add(LeaderboardEntryData.fromJson(data));
        } catch (error, stackTrace) {
          throw LeaderboardDeserializationException(error, stackTrace);
        }
      }
    }
    return leaderboardEntries;
  }
}
