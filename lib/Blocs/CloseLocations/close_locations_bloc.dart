import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'close_locations_event.dart';
part 'close_locations_state.dart';

class CloseLocationsBloc extends Bloc<CloseLocationsEvent, CloseLocationsState> {
  CloseLocationsBloc() : super(CloseLocationsInitial()) {
    on<CloseLocationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
