import 'dart:async';
import 'dart:developer';

import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repositories/contacts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_list_event.dart';
part 'contact_list_state.dart';
part 'contact_list_bloc.freezed.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final ContactsRepository _repository;

  ContactListBloc({required ContactsRepository repository})
      : _repository = repository,
        super(ContactListState.initial()) {
    on<_ContaContactListEventFindAll>(_findAll);
    on<_ContactListEventDelete>(_delete);
  }

  FutureOr<void> _findAll(_ContaContactListEventFindAll event,
      Emitter<ContactListState> emit) async {
    try {
      emit(ContactListState.loading());
      final contacts = await _repository.findAll();

      // await Future.delayed(const Duration(seconds: 1));
      emit(ContactListState.data(contacts: contacts));
    } catch (e, s) {
      log('Erro ao buscar Contatos', error: e, stackTrace: s);
      emit(ContactListState.error(error: 'Erro ao Buscar Contatos'));
    }
  }

  FutureOr<void> _delete(
      _ContactListEventDelete event, Emitter<ContactListState> emit) async {
    try {
      emit(ContactListState.loading());

      await _repository.delete(event.contact).then(
        (value) async {
          final contacts = await _repository.findAll();

          await Future.delayed(const Duration(seconds: 1));
          emit(ContactListState.data(contacts: contacts));
        },
      );
    } catch (e, s) {
      log('Erro ao Deletar Contato', error: e, stackTrace: s);
      emit(ContactListState.error(error: 'Erro ao Deletar Contato'));
    }
  }
}
