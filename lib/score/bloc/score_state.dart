part of 'score_bloc.dart';

enum ScoreStatus {
  gameOver,
  leaderboard,
}

enum InitialsFormStatus {
  initial,
  loading,
  success,
  invalid,
  failure,
  blacklisted,
}

class ScoreState extends Equatable {
  const ScoreState({
    this.status = ScoreStatus.gameOver,
    this.initials = '',
    this.id = '',
  });

  final String id;
  final ScoreStatus status;
  final String initials;

  ScoreState copyWith({
    ScoreStatus? status,
    String? initials,
    String? id,
  }) {
    return ScoreState(
      status: status ?? this.status,
      initials: initials ?? this.initials,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [
        status,
        initials,
        id,
      ];
}
