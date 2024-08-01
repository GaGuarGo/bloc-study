import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(ExampleStateInitial()) {
    on<ExampleFindNameEvent>(_findNames);
    on<ExampleRemoveNameEvent>(_removeName);
  }

  FutureOr<void> _findNames(
      ExampleFindNameEvent event, Emitter<ExampleState> emit) async {
    final names = [
      'Gabriel Gomes',
      'Henrique Moraes',
      'Guilherme',
      'Vitor',
      'Flutter',
      'Dart'
    ];

    await Future.delayed(const Duration(seconds: 4));

    emit(ExampleStateData(names: names));
  }

  FutureOr<void> _removeName(
      ExampleRemoveNameEvent event, Emitter<ExampleState> emit) {
    final stateExample = state;

    if (stateExample is ExampleStateData) {
      final names = [...stateExample.names];
      names.retainWhere((element) => element != event.name);
      emit(ExampleStateData(names: names));
    }
  }
}
