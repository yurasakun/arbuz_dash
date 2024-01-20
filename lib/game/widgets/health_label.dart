import 'package:arbuz_dash/game/bloc/game_bloc.dart';
import 'package:arbuz_dash/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HealthLabel extends StatelessWidget {
  const HealthLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final health = context.select(
      (GameBloc bloc) => bloc.state.health,
    );
    final live = List<int>.generate(health, (counter) => counter);
    if (health != 0) {
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
                ...live.map(
                  (e) => Row(
                    children: [
                      Assets.images.health.image(
                        width: 18,
                        height: 18,
                      ),
                      if (live.last != e) const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
