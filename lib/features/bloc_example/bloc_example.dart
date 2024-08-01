import 'package:contact_bloc/features/bloc_example/bloc/example_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocExample extends StatelessWidget {
  const BlocExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Example'),
      ),
      body: BlocListener<ExampleBloc, ExampleState>(
        listenWhen: (previous, current) {
          // if (previous is ExampleStateInitial && current is ExampleStateData) {
          //   if (current.names.length > 3) {
          //     return true;
          //   }
          // }
          // return false;
          return current is ExampleStateData;
        },
        listener: (context, state) {
          if (state is ExampleStateData) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text('A quantidade de nomes é ${state.names.length}')));
          }
        },
        child: Column(
          children: [
            BlocConsumer<ExampleBloc, ExampleState>(
              builder: (context, state) {
                if (state is ExampleStateData) {
                  return Text("Total de Nomes: ${state.names.length}");
                }
                return const SizedBox.shrink();
              },
              listener: (context, state) {},
            ),
            BlocSelector<ExampleBloc, ExampleState, bool>(
              selector: (state) {
                if (state is ExampleStateInitial) {
                  return true;
                }
                return false;
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
            BlocBuilder<ExampleBloc, ExampleState>(
              // buildWhen: (previous, current) {
              //   if (previous is ExampleStateInitial &&
              //       current is ExampleStateData) {
              //     if (current.names.length > 4) {
              //       return true;
              //     }
              //   }
              //   return false;
              // },
              builder: (context, state) {
                if (state is ExampleStateData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.names.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.names[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<ExampleBloc>().add(
                                  ExampleRemoveNameEvent(
                                    name: state.names[index],
                                  ),
                                );
                          },
                        ),
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
