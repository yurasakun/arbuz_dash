import 'package:arbuz_dash/game/bloc/game_bloc.dart';
import 'package:arbuz_dash/gen/assets.gen.dart';
import 'package:arbuz_dash/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreLabel extends StatelessWidget {
  const ScoreLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final score = context.select(
      (GameBloc bloc) => bloc.state.score,
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF001C34),
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
                    TextSpan(text: l10n.gameScoreLabel(score)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
