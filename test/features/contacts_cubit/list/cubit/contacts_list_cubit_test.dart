import 'package:bloc_test/bloc_test.dart';
import 'package:contact_bloc/features/contacts_cubit/list/cubit/contacts_list_cubit.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repositories/contacts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

void main() {
  //declaração

  late ContactsRepository repository;
  late ContactsListCubit cubit;
  late List<ContactModel> contacts;

//preparação

  setUp(() {
    repository = MockContactsRepository();
    cubit = ContactsListCubit(repository: repository);
    contacts = [
      ContactModel(name: 'Gabriel Gomes', email: 'gabriel@gmail.com'),
      ContactModel(name: 'Gustavo Gomes', email: 'gustavo@gmail.com'),
      ContactModel(name: 'Henrique Gomes', email: 'henrique@gmail.com'),
    ];
  });

  //execução
  blocTest<ContactsListCubit, ContactsListCubitState>(
    'Deve buscar os contatos',
    build: () => cubit,
    act: (cubit) => cubit.findAll(),
    setUp: () {
      when(
        () => repository.findAll(),
      ).thenAnswer((invocation) async => contacts);
    },
    expect: () => [
      const ContactsListCubitState.loading(),
      ContactsListCubitState.data(contacts: contacts),
    ],
  );
}
