import 'package:app_ui/app_ui.dart';
import 'package:arbuz_dash/leaderboard/leaderboard.dart';
import 'package:arbuz_dash/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AudioButton extends StatelessWidget {
  const AudioButton({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    return ValueListenableBuilder<bool>(
      valueListenable: settingsController.muted,
      builder: (context, muted, child) => GameIconButton(
        icon: muted ? Icons.volume_off : Icons.volume_up,
        onPressed: context.read<SettingsController>().toggleMuted,
      ),
    );
  }
}

class LeaderboardButton extends StatelessWidget {
  const LeaderboardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GameIconButton(
      icon: FontAwesomeIcons.trophy,
      size: 18,
      alignment: const Alignment(-0.3, 0),
      onPressed: () => Navigator.of(context).push(LeaderboardPage.route()),
    );
  }
}


