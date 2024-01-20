part of 'score_bloc.dart';

sealed class ScoreEvent extends Equatable {
  const ScoreEvent();

  @override
  List<Object> get props => [];
}

final class ScoreSubmitted extends ScoreEvent {
  const ScoreSubmitted();
}

final class ScoreNameUpdated extends ScoreEvent {
  const ScoreNameUpdated({
    required this.value,
    required this.id,
  });
  final String id;
  final String value;
}

final class ScoreInitialsSubmitted extends ScoreEvent {
  const ScoreInitialsSubmitted();
}

final class ScoreLeaderboardRequested extends ScoreEvent {
  const ScoreLeaderboardRequested();
}
