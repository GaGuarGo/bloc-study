import 'package:contact_bloc/features/contacts/list/bloc/contact_list_bloc.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/contacts/register');
          // ignore: use_build_context_synchronously
          context.read<ContactListBloc>().add(const ContactListEvent.findAll());
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<ContactListBloc, ContactListState>(
        listenWhen: (previous, current) =>
            current.maybeWhen(orElse: () => false, error: (error) => true),
        listener: (context, state) {
          state.whenOrNull(
            error: (error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error)));
            },
          );
        },
        child: RefreshIndicator(
          onRefresh: () async {
            context
                .read<ContactListBloc>()
                .add(const ContactListEvent.findAll());
          },
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(
                  children: [
                    Loader<ContactListBloc, ContactListState>(
                      selector: (state) => state.maybeWhen(
                          orElse: () => false, loading: () => true),
                    ),
                    BlocSelector<ContactListBloc, ContactListState,
                        List<ContactModel>>(
                      selector: (state) {
                        return state.maybeWhen(
                            orElse: () => [], data: (contacts) => contacts);
                      },
                      builder: (context, contacts) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];

                            return ListTile(
                              onTap: () async {
                                await Navigator.pushNamed(
                                    context, '/contacts/update',
                                    arguments: contact);
                                context
                                    .read<ContactListBloc>()
                                    .add(const ContactListEvent.findAll());
                              },
                              title: Text(contact.name),
                              subtitle: Text(contact.email),
                              trailing: IconButton(
                                onPressed: () {
                                  context.read<ContactListBloc>().add(
                                      ContactListEvent.delete(
                                          contact: contact));
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
