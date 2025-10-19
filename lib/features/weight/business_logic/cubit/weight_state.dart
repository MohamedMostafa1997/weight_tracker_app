part of 'weight_cubit.dart';

sealed class WeightState extends Equatable {
  const WeightState();

  @override
  List<Object> get props => [];
}

final class WeightInitial extends WeightState {}

final class WeightLoading extends WeightState {}

final class WeightLoaded extends WeightState {
  final List<WeightEntry> weights;

  const WeightLoaded(this.weights);

  @override
  List<Object> get props => [weights];
}

final class WeightFailure extends WeightState {
  final String message;
  const WeightFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class WeightSuccess extends WeightState {}

