import 'package:bloc/bloc.dart';
import 'package:chat_app/app/feature/dashboard/main_dashboard/dashboard_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../sdk/enum/loading_status.dart';

class DashCubit extends Cubit<DashState> {
  DashCubit() : super(const DashState());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchUsers() async {
    emit(state.copyWith(status: Status.isLoading));
    try {
      final querySnapshot = await _firestore.collection('users').get();
      final users = querySnapshot.docs.map((doc) => doc.data()).toList();
      emit(state.copyWith(contact: users, filterContact: users, status: Status.loaded));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
      rethrow;
    }
  }

  void searchUsers(String query) {
    emit(state.copyWith(status: Status.isLoading));
    try {
      final filteredList = state.contact
          .where((user) =>
              user['email'] != null &&
              user['email'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(state.copyWith(
          filterContact: filteredList, searchQuery: query, status: Status.loaded));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
      rethrow;
    }
  }

  void clearSearch() {
    emit(state.copyWith(filterContact: state.contact, searchQuery: ''));
  }
}
