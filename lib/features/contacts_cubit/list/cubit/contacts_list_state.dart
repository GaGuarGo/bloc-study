part of 'contacts_list_cubit.dart';

@freezed
class ContactsListCubitState with _$ContactsListCubitState {
  const factory ContactsListCubitState.initial() = _Initial;
  const factory ContactsListCubitState.loading() = _Loading;
  const factory ContactsListCubitState.data({required List<ContactModel> contacts}) = _Data;
  const factory ContactsListCubitState.error({required String error}) = _Error;

}
