import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:arbuz_dash/game/game.dart';
import 'package:arbuz_dash/game_intro/game_intro.dart';
import 'package:arbuz_dash/gen/assets.gen.dart';
import 'package:arbuz_dash/l10n/l10n.dart';
import 'package:arbuz_dash/leaderboard/view/leaderboard_page.dart';
import 'package:arbuz_dash/score/score.dart';
import 'package:arbuz_dash/user/bloc/user_bloc.dart';
import 'package:arbuz_dash/utils/utils.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class GameOverPage extends StatelessWidget {
  const GameOverPage({super.key});

  static Page<void> page() {
    return const MaterialPage(
      child: GameOverPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    const titleColor = Colors.white;

    return PageWithBackground(
      background: const GameBackground(),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.gameOverBg.provider(),
            fit: BoxFit.cover,
            alignment:
                isDesktop ? const Alignment(0, -.5) : Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 15),
            Text(
              l10n.gameOver,
              style: textTheme.headlineMedium?.copyWith(
                color: titleColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              l10n.betterLuckNextTime,
              style: textTheme.bodyLarge?.copyWith(
                color: titleColor,
              ),
            ),
            const Spacer(flex: 4),
            Text(
              l10n.totalScore,
              style: textTheme.bodyLarge?.copyWith(
                color: titleColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(flex: 2),
            const _ScoreWidget(),
            const Spacer(flex: 4),
            GameElevatedButton(
              color: const Color(0xFF0B13A0),
              label: 'Menu',
              onPressed: () {
                Navigator.of(context).push(GameIntroPage.route());
              },
            ),
            const Spacer(flex: 3),
            GameElevatedButton.icon(
              label: l10n.playAgain,
              icon: const Icon(Icons.refresh, size: 16),
              onPressed: () {
                context.flow<ScoreState>().complete();
                Navigator.of(context).push(Game.route());
              },
            ),
            const Spacer(flex: 3),
            GameElevatedButton(
              label: 'Leader Board',
              onPressed: () {
                Navigator.of(context).push(LeaderboardPage.route());
              },
            ),
            const Spacer(flex: 40),
            const BottomBar(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ScoreWidget extends StatefulWidget {
  const _ScoreWidget();

  @override
  State<_ScoreWidget> createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<_ScoreWidget> {
  @override
  void initState() {
    super.initState();

    context
        .read<UserBloc>()
        .add(UpdateScoreUserEvent(newScore: context.read<ScoreBloc>().score));

    context.read<ScoreBloc>().add(ScoreNameUpdated(
        value: context.read<UserBloc>().state.user.fullName,
        id: context.read<UserBloc>().state.user.id));

    context.read<ScoreBloc>().add(const ScoreInitialsSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final score = context.select((ScoreBloc bloc) => bloc.score);

    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF001C34), width: 3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.trophy.image(width: 18, height: 18),
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              style: textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: '${formatScore(score)} '),
                TextSpan(
                  text: l10n.pts,
                  style: textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatScore(int score) {
    final formatter = NumberFormat('#,###');
    return formatter.format(score);
  }

  String generateRandomString(int len) {
    final r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }
}
