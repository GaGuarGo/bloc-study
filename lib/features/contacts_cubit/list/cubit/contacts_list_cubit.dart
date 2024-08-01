import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repositories/contacts_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contacts_list_state.dart';
part 'contacts_list_cubit.freezed.dart';

class ContactsListCubit extends Cubit<ContactsListCubitState> {
  final ContactsRepository _repository;

  ContactsListCubit({required ContactsRepository repository})
      : _repository = repository,
        super(const ContactsListCubitState.initial());

  Future<void> findAll() async {
    try {
      emit(const ContactsListCubitState.loading());

      final contacts = await _repository.findAll();

      await Future.delayed(const Duration(seconds: 1));

      emit(ContactsListCubitState.data(contacts: contacts));
    } catch (e, s) {
      log('Erro ao buscar Contatos', error: e, stackTrace: s);
      emit(
          const ContactsListCubitState.error(error: 'Erro ao Buscar Contatos'));
    }
  }

  Future<void> deleteByModel(ContactModel model) async {
    emit(const ContactsListCubitState.loading());

    await _repository.delete(model);
    findAll();
  }
}
