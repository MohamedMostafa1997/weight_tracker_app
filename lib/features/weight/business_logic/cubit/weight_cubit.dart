import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weight_tracker_app/features/weight/business_logic/weight_repo.dart';
import 'package:weight_tracker_app/features/weight/model/weight_entry.dart';

part 'weight_state.dart';

class WeightCubit extends Cubit<WeightState> {
  final WeightRepo repo;
  StreamSubscription<List<WeightEntry>>? _subscription;

  WeightCubit(this.repo) : super(WeightInitial());

  void startListening() {
    emit(WeightLoading());
    _subscription?.cancel();
    _subscription = repo.userWeightsStream().listen(
      (weights) => emit(WeightLoaded(weights)),
      onError: (e) => emit(WeightFailure(e.toString())),
    );
  }

  Future<void> addWeight(double weight) async {
    try {
      await repo.addWeight(weight);
    } catch (e) {
      emit(WeightFailure(e.toString()));
    }
  }

  Future<void> updateWeight(String id, double weight) async {
    try {
      await repo.updateWeight(id, weight);
    } catch (e) {
      emit(WeightFailure(e.toString()));
    }
  }

  Future<void> deleteWeight(String id) async {
    try {
      await repo.deleteWeight(id);
    } catch (e) {
      emit(WeightFailure(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
