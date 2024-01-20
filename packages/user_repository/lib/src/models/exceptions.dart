/// {@template user_exception}
/// Base exception for user repository failures.
/// {@endtemplate}
abstract class UserException implements Exception {
  /// {@macro user_exception}
  const UserException(this.error, this.stackTrace);

  /// The error that was caught.
  final Object error;

  /// The Stacktrace associated with the [error].
  final StackTrace stackTrace;
}

/// {@template user_deserialization_exception}
/// Exception thrown when user data cannot be deserialized in the
/// expected way.
/// {@endtemplate}
class UserDeserializationException extends UserException {
  /// {@macro user_deserialization_exception}
  const UserDeserializationException(super.error, super.stackTrace);
}

/// {@template fetch_user_exception}
/// Exception thrown when failure occurs while fetching top 10 leaderboard.
/// {@endtemplate}
class FetchUserException extends UserException {
  /// {@macro fetch_user_exception}
  const FetchUserException(super.error, super.stackTrace);
}

/// {@template fetch_users_exception}
/// Exception thrown when failure occurs while fetching the leaderboard.
/// {@endtemplate}
class FetchUsersException extends UserException {
  /// {@macro fetch_users_exception}
  const FetchUsersException(super.error, super.stackTrace);
}

/// {@template add_user_entry_exception}
/// Exception thrown when failure occurs while adding entry to leaderboard.
/// {@endtemplate}
class AddUserEntryException extends UserException {
  /// {@macro add_user_entry_exception}
  const AddUserEntryException(super.error, super.stackTrace);
}
