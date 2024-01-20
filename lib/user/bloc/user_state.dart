part of 'user_bloc.dart';

enum UserStatus {
  auth,
  none,
  loading,
  error
}

final
class UserState {
const UserState({
this.user = users,
this.status = UserStatus.none,
});

final UserStatus status;

final User user;

UserState copyWith({
UserStatus? status,
User? user,
}) {
return UserState(
status: status ?? this.status,
user: user ?? this.user,
);
}

List<Object> get props => [user, status];
}

const User users = User(id: '', authDate: '', lastScore: 0, fullName: '',
userName: '',);
