import 'package:bloc/bloc.dart';
import 'package:chat_app/app/feature/auth/signup/register_state.dart';
import 'package:chat_app/app/sdk/enum/loading_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void togglePassword() {
    emit(state.copyWith(isVisible: !state.isVisible));
  }

  Future<void> registerAccount(String email, String password) async {
    try {
      emit(state.copyWith(status: Status.isLoading));
      final auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'password': password,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      emit(state.copyWith(status: Status.loaded));
    } catch (e) {
      String errorMessage;
      if (e.toString().contains('email-already-in-use')) {
        errorMessage = 'This email is already registered. Try logging in.';
      } else if (e.toString().contains('wrong-password')) {
        errorMessage = 'Incorrect password. Please try again.';
      } else if (e.toString().contains('user-not-found')) {
        errorMessage = 'No user found with this email.';
      } else {
        errorMessage = 'Something went wrong. Please try again.';
      }
      emit(state.copyWith(status: Status.error, errorMessage: errorMessage));
    }
  }
}
