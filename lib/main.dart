import 'dart:async';

import 'package:arbuz_dash/app/app.dart';
import 'package:arbuz_dash/audio/audio.dart';
import 'package:arbuz_dash/bootstrap.dart';
import 'package:arbuz_dash/firebase_options_prod.dart';
import 'package:arbuz_dash/settings/persistence/persistence.dart';
import 'package:arbuz_dash/settings/settings.dart';
import 'package:arbuz_dash/share/share.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:leaderboard_repository/leaderboard_repository.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final settings = SettingsController(
    persistence: LocalStorageSettingsPersistence(),
  );

  final audio = AudioController()..attachSettings(settings);

  await audio.initialize();

  final share = ShareController(
    gameUrl: 'https://superdash.flutter.dev/',
  );

  final leaderboardRepository = LeaderboardRepository(
    FirebaseFirestore.instance,
  );

  final userRepository = UserRepository(
    FirebaseFirestore.instance,
  );

  unawaited(
    bootstrap(
      (firebaseAuth) async {
        final authenticationRepository = AuthenticationRepository(
          firebaseAuth: firebaseAuth,
        );

        return App(
          audioController: audio,
          settingsController: settings,
          shareController: share,
          authenticationRepository: authenticationRepository,
          leaderboardRepository: leaderboardRepository,
          userRepository: userRepository,
        );
      },
    ),
  );
}
