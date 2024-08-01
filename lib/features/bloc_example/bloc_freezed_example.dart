import 'package:contact_bloc/features/bloc_example/bloc_freezed/example_freezed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocFreezedExample extends StatelessWidget {
  const BlocFreezedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Freezed'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<ExampleFreezedBloc>()
              .add(ExampleFreezedEvent.addName('Novo Nome Freezed'));
        },
      ),
      body: BlocListener<ExampleFreezedBloc, ExampleFreezedState>(
        listener: (context, state) {
          state.whenOrNull(
            showBanner: (message, names) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            },
          );
        },
        child: Column(
          children: [
            BlocSelector<ExampleFreezedBloc, ExampleFreezedState, bool>(
              selector: (state) {
                return state.maybeWhen(
                    orElse: () => false, loading: () => true);
              },
              builder: (context, state) {
                if (state) {
                  return const Expanded(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
                }
                return const SizedBox.shrink();
              },
            ),
            BlocSelector<ExampleFreezedBloc, ExampleFreezedState, List<String>>(
              selector: (state) {
                return state.maybeWhen(
                    orElse: () => <String>[],
                    data: (names) => names,
                    showBanner: (message, names) => names);
              },
              builder: (context, names) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(names[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // context
                          //     .read<ExampleBloc>()
                          //     .add(ExampleRemoveNameEvent(name: names[index]));
                        },
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
