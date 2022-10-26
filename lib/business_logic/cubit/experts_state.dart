part of 'experts_cubit.dart';

@immutable
abstract class ExpertsState {}

class ExpertsInitial extends ExpertsState {}

class ExpertsAdded extends ExpertsState {
  final List<Expert> experts;
  final List<Expert> online_experts;
  final String id;

  ExpertsAdded(this.experts, this.id, this.online_experts);
}

class ExpertsLoading extends ExpertsState {}

class NoExperts extends ExpertsState {}
