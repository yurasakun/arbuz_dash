import 'package:app_ui/app_ui.dart';
import 'package:arbuz_dash/app_lifecycle/app_lifecycle.dart';
import 'package:arbuz_dash/audio/audio.dart';
import 'package:arbuz_dash/game_intro/game_intro.dart';
import 'package:arbuz_dash/l10n/l10n.dart';
import 'package:arbuz_dash/settings/settings.dart';
import 'package:arbuz_dash/share/share.dart';
import 'package:arbuz_dash/user/bloc/user_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaderboard_repository/leaderboard_repository.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required this.audioController,
    required this.settingsController,
    required this.shareController,
    required this.authenticationRepository,
    required this.leaderboardRepository,
    required this.userRepository,
    this.isTesting = false,
    super.key,
  });

  final bool isTesting;
  final AudioController audioController;
  final SettingsController settingsController;
  final ShareController shareController;
  final AuthenticationRepository authenticationRepository;
  final LeaderboardRepository leaderboardRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AudioController>(
            create: (context) {
              final lifecycleNotifier =
                  context.read<ValueNotifier<AppLifecycleState>>();
              return audioController
                ..attachLifecycleNotifier(lifecycleNotifier);
            },
            lazy: false,
          ),
          RepositoryProvider<SettingsController>.value(
            value: settingsController,
          ),
          RepositoryProvider<ShareController>.value(
            value: shareController,
          ),
          RepositoryProvider<AuthenticationRepository>.value(
            value: authenticationRepository..signInAnonymously(),
          ),
          RepositoryProvider<LeaderboardRepository>.value(
            value: leaderboardRepository,
          ),
          RepositoryProvider<UserRepository>.value(
            value: userRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<UserBloc>(
              create: (BuildContext context) => UserBloc(
                 userRepository:   context.read<UserRepository>(),
              )..add(const LoaderUserRequested()),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData(
              textTheme: AppTextStyles.textTheme,
            ),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: const GameIntroPage(),
          ),
        ),
      ),
    );
  }
}
