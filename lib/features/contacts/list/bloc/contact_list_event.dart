part of 'contact_list_bloc.dart';

@freezed
class ContactListEvent with _$ContactListEvent{

  const factory ContactListEvent.findAll() = _ContaContactListEventFindAll;
  const factory ContactListEvent.delete({required ContactModel contact}) = _ContactListEventDelete;
}