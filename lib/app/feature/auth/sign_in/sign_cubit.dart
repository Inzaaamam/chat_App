import 'package:bloc/bloc.dart';
import 'package:chat_app/app/feature/auth/sign_in/sign_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../sdk/enum/loading_status.dart';

class SignCubit extends Cubit<SignState> {
  SignCubit() : super(const SignState());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: Status.isLoading));
      final auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      emit(state.copyWith(status: Status.loaded));
    } catch (e) {
      // String errorMessage;
      emit(state.copyWith(status: Status.error, errorMessage: e.toString()));
      rethrow;
    }
  }
}
