part of 'operators_bloc.dart';

@immutable
sealed class OperatorsEvent {}

class FetchOperators extends OperatorsEvent {}

class RefreshOperators extends OperatorsEvent {}
