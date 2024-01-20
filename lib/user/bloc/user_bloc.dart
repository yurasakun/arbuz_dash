import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:user_repository/user_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserState()) {
    on<LoaderUserRequested>(_onUsersRequested);
    on<UpdateScoreUserEvent>(_onUpdateUserScore);
  }

  final UserRepository _userRepository;

  final WebAppInitData webAppInitData = tg.initDataUnsafe;

  Future<void> _onUsersRequested(
    LoaderUserRequested event,
    Emitter<UserState> emit,
  ) async {
    try {
      //Add telegram
      if (state.status != UserStatus.auth) {
        emit(state.copyWith(status: UserStatus.loading));
        final user = await _userRepository.getUserById(
          webAppInitData.user?.id.toString() ?? '58321872',
        ); //58321874
        if (user != null) {
          emit(state.copyWith(user: user, status: UserStatus.auth));
        } else {
          final tgUser = webAppInitData.user;
          final auth = webAppInitData.auth_date;
          if (tgUser != null && auth != null) {
            final user = User(
              id: tgUser.id.toString(),
              authDate:  auth.toString(),
              lastScore: 0,
              fullName: '${tgUser.first_name} ${tgUser.last_name}',
              userName: tgUser.username,
            );
            await _userRepository.addUser(user);
            emit(state.copyWith(user: user, status: UserStatus.auth));
          }
        }
      }
    } catch (e) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  Future<void> _onUpdateUserScore(
    UpdateScoreUserEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      final user = User(
        id: state.user.id,
        authDate: state.user.authDate,
        lastScore: event.newScore,
        fullName: state.user.fullName,
        userName: state.user.userName,
      );

      await _userRepository.updateUser(user);

      emit(state.copyWith(user: user, status: UserStatus.auth));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }
}
