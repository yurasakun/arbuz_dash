import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_repository.dart';

/// {@template user_repository}
/// Repository to access leaderboard data in Firebase Cloud Firestore.
/// {@endtemplate}
class UserRepository {
  /// {@macro leaderboard_repository}
  const UserRepository(
    FirebaseFirestore firebaseFirestore,
  ) : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  static const _userCollectionName = 'user';

  ///
  Future<void> addUser(User user) async {
    await _firebaseFirestore
        .collection(_userCollectionName)
        .doc(user.id)
        .set(user.toJson());
  }

  ///
  Future<void> updateUser(User user) async {
    try {
      await _firebaseFirestore
          .collection(_userCollectionName)
          .doc(user.id)
          .update(user.toJson());
    } catch (e) {}
  }

  Future<void> addUserById(String userId, Map<String, dynamic> userData) async {
    await _firebaseFirestore
        .collection(_userCollectionName)
        .doc(userId)
        .set(userData);
  }

  ///
  Future<User?> getUserById(String userId) async {
    final snapshot = await _firebaseFirestore
        .collection(_userCollectionName)
        .doc(userId)
        .get();
    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }
}
