part of 'example_bloc.dart';

abstract class ExampleEvent {}

class ExampleFindNameEvent extends ExampleEvent {}

class ExampleAddNameEvent extends ExampleEvent {}

class ExampleRemoveNameEvent extends ExampleEvent {
  ExampleRemoveNameEvent({required this.name});
  final String name;
}
