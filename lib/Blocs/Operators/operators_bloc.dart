import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'operators_event.dart';
part 'operators_state.dart';

class OperatorsBloc extends Bloc<OperatorsEvent, OperatorsState> {
  OperatorsBloc() : super(OperatorsInitial()) {
    on<OperatorsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
