import 'package:bloc_test/bloc_test.dart';
import 'package:contact_bloc/features/contacts/list/bloc/contact_list_bloc.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repositories/contacts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

void main() {
//declaração

  late ContactsRepository repository;
  late ContactListBloc bloc;
  late List<ContactModel> contacts;

//preparação

  setUp(() {
    repository = MockContactsRepository();
    bloc = ContactListBloc(repository: repository);
    contacts = [
      ContactModel(name: 'Gabriel Gomes', email: 'gabriel@gmail.com'),
      ContactModel(name: 'Gustavo Gomes', email: 'gustavo@gmail.com'),
      ContactModel(name: 'Henrique Gomes', email: 'henrique@gmail.com'),
    ];
  });

//execução

  blocTest<ContactListBloc, ContactListState>(
    'Deve buscar os contatos',
    build: () => bloc,
    act: (bloc) => bloc.add(const ContactListEvent.findAll()),
    setUp: () {
      when(
        () => repository.findAll(),
      ).thenAnswer((invocation) async => contacts);
    },
    expect: () => [
      ContactListState.loading(),
      ContactListState.data(contacts: contacts),
    ],
  );
  blocTest<ContactListBloc, ContactListState>(
    'Deve retornar erro ao buscar contatos',
    build: () => bloc,
    act: (bloc) => bloc.add(const ContactListEvent.findAll()),
    // setUp: () {
    //   when(
    //     () => repository.findAll(),
    //   ).thenAnswer((invocation) async => contacts);
    // },
    expect: () => [
      ContactListState.loading(),
      ContactListState.error(error: 'Erro ao Buscar Contatos'),
    ],
  );
}
