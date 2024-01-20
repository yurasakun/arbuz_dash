import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leaderboard_repository/leaderboard_repository.dart';

part 'score_event.dart';

part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc({
    required this.score,
    required LeaderboardRepository leaderboardRepository,
  })  : _leaderboardRepository = leaderboardRepository,
        super(const ScoreState()) {
    on<ScoreNameUpdated>(_onScoreInitialsUpdated);
    on<ScoreInitialsSubmitted>(_onScoreInitialsSubmitted);
    on<ScoreLeaderboardRequested>(_onScoreLeaderboardRequested);
  }

  final int score;
  final LeaderboardRepository _leaderboardRepository;

  void _onScoreInitialsUpdated(
    ScoreNameUpdated event,
    Emitter<ScoreState> emit,
  ) {
    final initials = event.value;

    emit(state.copyWith(initials: initials, id: event.id));
  }

  Future<void> _onScoreInitialsSubmitted(
    ScoreInitialsSubmitted event,
    Emitter<ScoreState> emit,
  ) async {
    try {
      await _leaderboardRepository.addLeaderboardEntry(
        LeaderboardEntryData(
          playerInitials: state.initials,
          score: score,
        ),
        state.id,
      );
    } catch (e, s) {
      addError(e, s);
    }
  }

  void _onScoreLeaderboardRequested(
    ScoreLeaderboardRequested event,
    Emitter<ScoreState> emit,
  ) {
    emit(
      state.copyWith(
        status: ScoreStatus.leaderboard,
      ),
    );
  }
}
