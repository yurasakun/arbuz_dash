import 'package:arbuz_dash/gen/assets.gen.dart';
import 'package:arbuz_dash/l10n/l10n.dart';
import 'package:arbuz_dash/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UserScore extends StatelessWidget {
  const UserScore({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final score = context.select((UserBloc bloc) => bloc.state.user.lastScore);

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
}
