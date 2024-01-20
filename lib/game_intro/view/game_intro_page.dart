import 'package:app_ui/app_ui.dart';
import 'package:arbuz_dash/game/game.dart';
import 'package:arbuz_dash/game_intro/game_intro.dart';
import 'package:arbuz_dash/gen/assets.gen.dart';
import 'package:arbuz_dash/l10n/l10n.dart';
import 'package:arbuz_dash/user/bloc/user_bloc.dart';
import 'package:arbuz_dash/user/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameIntroPage extends StatefulWidget {
  const GameIntroPage({super.key});

  static PageRoute<void> route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const GameIntroPage(),
    );
  }

  @override
  State<GameIntroPage> createState() => _GameIntroPageState();
}

class _GameIntroPageState extends State<GameIntroPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(Assets.images.gameBackground.provider(), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: context.isSmall
                ? Assets.images.introBackgroundMobile.provider()
                : Assets.images.introBackgroundDesktop.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) => switch (state.status) {
            UserStatus.error => const _IntroPage(),
            UserStatus.none => const _IntroPage(),
            UserStatus.auth => const _IntroPage(
                userDetails: UserScore(),
              ),
            UserStatus.loading => const _IntroPage()
          },
        ),
      ),
    );
  }
}

class _IntroPage extends StatelessWidget {
  const _IntroPage({this.userDetails});

  final Widget? userDetails;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final userDetailsWidget = userDetails;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 490),
        child: Column(
          children: [
            const Spacer(),
            Assets.images.gameLogo.image(
              width: context.isSmall ? 282 : 380,
            ),
            if (userDetailsWidget != null)
              Column(
                children: [
                  userDetailsWidget,
                ],
              ),
            const SizedBox(height: 32),
            GameElevatedButton(
              label: l10n.gameIntroPagePlayButtonText,
              onPressed: () => Navigator.of(context).push(Game.route()),
            ),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AudioButton(),
                LeaderboardButton(),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
