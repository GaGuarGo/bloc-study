import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_freezed_state.dart';
part 'example_freezed_event.dart';

part 'example_freezed_bloc.freezed.dart';

class ExampleFreezedBloc
    extends Bloc<ExampleFreezedEvent, ExampleFreezedState> {
  ExampleFreezedBloc() : super(ExampleFreezedState.initial()) {
    on<_ExampleFreezedEventFindNames>(_findNames);
    on<_ExampleFreezedEventRemoveName>(_removeName);
    on<_ExampleFreezedEventAddName>(_addName);
  }

  FutureOr<void> _findNames(_ExampleFreezedEventFindNames event,
      Emitter<ExampleFreezedState> emit) async {
    emit(ExampleFreezedState.loading());

    final names = [
      'Gabriel Gomes',
      'Henrique Moraes',
      'Guilherme',
      'Vitor',
      'Flutter',
      'Dart'
    ];

    await Future.delayed(const Duration(seconds: 2));

    emit(ExampleFreezedState.data(names: names));
  }

  FutureOr<void> _addName(_ExampleFreezedEventAddName event,
      Emitter<ExampleFreezedState> emit) async {
    final names = state.maybeWhen(
      data: (names) => names,
      orElse: () => const <String>[]
    );

    emit(ExampleFreezedState.showBanner(
        message: 'Nome Sendo Inserido!!!', names: names));

    await Future.delayed(const Duration(seconds: 2));

    final newNames = [...names];
    newNames.add(event.name);

    emit(ExampleFreezedState.data(names: newNames));
  }

  FutureOr<void> _removeName(
      _ExampleFreezedEventRemoveName event, Emitter<ExampleFreezedState> emit) {
    final names =
        state.maybeWhen(data: (names) => names, orElse: () => const <String>[]);

    final newNames = [...names];
    newNames.retainWhere((element) => element != event.name);
    emit(ExampleFreezedState.data(names: newNames));
  }
}
