part of 'example_freezed_bloc.dart';

@freezed
class ExampleFreezedState with _$ExampleFreezedState {

  factory ExampleFreezedState.initial() = _ExampleFreezedStateInitial;
  factory ExampleFreezedState.loading() = _ExampleFreezedStateLoading;
  factory ExampleFreezedState.showBanner({required String message, required List<String> names}) = _ExampleFreezedStateStateBanner;
  factory ExampleFreezedState.data({required List<String> names}) = _ExampleFreezedStateData;

}
