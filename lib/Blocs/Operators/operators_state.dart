part of 'operators_bloc.dart';

@immutable
sealed class OperatorsState {}

final class OperatorsInitial extends OperatorsState {}

final class OperatorsLoading extends OperatorsState {}

final class OperatorsLoaded extends OperatorsState {
  final List<Operator> Operators;

  OperatorsLoaded({required this.Operators});
}

final class OperatorsErrored extends OperatorsState {
  final String ErrorMessage;

  OperatorsErrored({required this.ErrorMessage});
}
