import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/detox_session.dart';
import 'package:dopamine_diary/features/diary/domain/usecases/end_detox.dart';
import 'package:dopamine_diary/features/diary/domain/usecases/get_active_detox.dart';
import 'package:dopamine_diary/features/diary/domain/usecases/start_detox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detox_event.dart';
part 'detox_state.dart';

/// Bloc cho Detox — load phiên active, start mới, end sớm.
/// Ticking thời gian còn lại do UI tự handle bằng Timer.periodic
/// (đọc `session.startTime + durationDays`).
class DetoxBloc extends Bloc<DetoxEvent, DetoxState> {
  final GetActiveDetox _getActiveDetox;
  final StartDetox _startDetox;
  final EndDetox _endDetox;

  DetoxBloc({
    required GetActiveDetox getActiveDetox,
    required StartDetox startDetox,
    required EndDetox endDetox,
  })  : _getActiveDetox = getActiveDetox,
        _startDetox = startDetox,
        _endDetox = endDetox,
        super(DetoxInitial()) {
    on<DetoxEvent>((event, emit) => emit(DetoxLoading()));
    on<DetoxLoadActiveRequested>(_onLoadActive);
    on<DetoxStartRequested>(_onStart);
    on<DetoxEndRequested>(_onEnd);
  }

  Future<void> _onLoadActive(
    DetoxLoadActiveRequested event,
    Emitter<DetoxState> emit,
  ) async {
    final res = await _getActiveDetox(NoParams());
    res.fold(
      (l) => emit(DetoxFailure(l.message)),
      (opt) => opt.fold(
        () => emit(DetoxIdle()),
        (session) => emit(DetoxRunning(session)),
      ),
    );
  }

  Future<void> _onStart(
    DetoxStartRequested event,
    Emitter<DetoxState> emit,
  ) async {
    final res = await _startDetox(StartDetoxParams(
      durationDays: event.durationDays,
      strictness: event.strictness,
      reason: event.reason,
      blockedApps: event.blockedApps,
    ));
    res.fold(
      (l) => emit(DetoxFailure(l.message)),
      (session) => emit(DetoxRunning(session)),
    );
  }

  Future<void> _onEnd(
    DetoxEndRequested event,
    Emitter<DetoxState> emit,
  ) async {
    final res = await _endDetox(EndDetoxParams(id: event.id));
    res.fold(
      (l) => emit(DetoxFailure(l.message)),
      (_) => emit(DetoxIdle()),
    );
  }
}
