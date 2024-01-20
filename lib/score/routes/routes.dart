import 'package:arbuz_dash/game_over/view/game_over_page.dart';
import 'package:arbuz_dash/leaderboard/leaderboard.dart';
import 'package:arbuz_dash/score/score.dart';
import 'package:flutter/material.dart';

List<Page<void>> onGenerateScorePages(
  ScoreState state,
  List<Page<void>> pages,
) {
  return switch (state.status) {
    ScoreStatus.gameOver => [GameOverPage.page()],
    ScoreStatus.leaderboard => [LeaderboardPage.page()],
  };
}
