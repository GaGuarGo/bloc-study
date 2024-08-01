import 'package:contact_bloc/features/contacts_cubit/list/cubit/contacts_list_cubit.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsCubitPage extends StatelessWidget {
  const ContactsCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Cubit'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ContactsListCubit>().findAll();
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  Loader<ContactsListCubit, ContactsListCubitState>(
                    selector: (state) => state.maybeWhen(
                        orElse: () => false, loading: () => true),
                  ),
                  BlocSelector<ContactsListCubit, ContactsListCubitState,
                      List<ContactModel>>(
                    selector: (state) {
                      return state.maybeWhen(
                          orElse: () => <ContactModel>[],
                          data: (contacts) => contacts);
                    },
                    builder: (context, contacts) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];

                          return ListTile(
                            title: Text(contact.name),
                            subtitle: Text(contact.email),
                            trailing: IconButton(
                              onPressed: () {
                                context
                                    .read<ContactsListCubit>()
                                    .deleteByModel(contact);
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
    );
  }
}
