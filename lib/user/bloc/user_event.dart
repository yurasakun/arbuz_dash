part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoaderUserRequested extends UserEvent {
  const LoaderUserRequested();
}

final class LoadUserEvent extends UserEvent {
  const LoadUserEvent({required this.value, required this.status,});

  final UserStatus status;
  final User value;
}

final class UpdateScoreUserEvent extends UserEvent{
const UpdateScoreUserEvent({required this.newScore});

final int newScore;
}


