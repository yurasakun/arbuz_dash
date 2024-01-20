part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({
    required this.score,
    required this.currentLevel,
    required this.currentSection,
    required this.health,
  });

  const GameState.initial()
      : score = 0,
        currentLevel = 1,
        currentSection = 0,
        health = 3;

  final int score;
  final int currentLevel;
  final int currentSection;
  final int health;

  GameState copyWith({
    int? score,
    int? currentLevel,
    int? currentSection,
    int? currentHealth,
  }) {
    return GameState(
      score: score ?? this.score,
      currentLevel: currentLevel ?? this.currentLevel,
      currentSection: currentSection ?? this.currentSection,
      health: currentHealth ?? health,
    );
  }

  @override
  List<Object?> get props => [score, currentLevel, currentSection, health];
}
