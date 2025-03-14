import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ro_transit_app/Utils/Operators.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:convert';

part 'operators_event.dart';
part 'operators_state.dart';

const _OperatorConfigURL =
    "https://raw.githubusercontent.com/FloreaCostinMario/MoveRo/refs/heads/main/config/Operators.json?token=GHSAT0AAAAAAC6T4434MLOIAIMDRC56SZ6IZ6ULMUQ";

class OperatorsBloc extends Bloc<OperatorsEvent, OperatorsState> {
  OperatorsBloc() : super(OperatorsInitial()) {
    on<FetchOperators>(_onFetchOperators);
    //on<RefreshOperators>(_onRefreshOperators);
  }

  Future<void> _onFetchOperators(
    FetchOperators event,
    Emitter<OperatorsState> emit,
  ) async {
    emit(OperatorsLoading());

    try {
      print("fetching operators");
      var file = await DefaultCacheManager().getSingleFile(_OperatorConfigURL);
      print("fetched");

      final Json = json.decode(utf8.decode(file.readAsBytesSync())) as List;
      print(Json);
      emit(
        OperatorsLoaded(
          Operators: Json.map((e) => Operator.fromJson(e)).toList(),
        ),
      );
    } catch (e) {
      emit(OperatorsErrored(ErrorMessage: e.toString()));
    }
  }
}
