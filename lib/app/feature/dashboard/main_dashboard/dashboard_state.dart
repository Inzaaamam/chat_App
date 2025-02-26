import 'package:equatable/equatable.dart';

import '../../../sdk/enum/loading_status.dart';

class DashState extends Equatable {
  const DashState(
      {this.contact = const [],
      this.filterContact = const [],
      this.searchQuery = '',
      this.status = Status.initial});
  final List contact;
  final List filterContact;
  final String searchQuery;
  final Status status;
  DashState copyWith(
      {List? contact, List? filterContact, String? searchQuery, Status? status}) {
    return DashState(
        contact: contact ?? this.contact,
        filterContact: filterContact ?? this.filterContact,
        searchQuery: searchQuery ?? this.searchQuery,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [contact, filterContact];
}
