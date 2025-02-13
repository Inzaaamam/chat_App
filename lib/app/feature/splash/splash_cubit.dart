import 'package:bloc/bloc.dart';
import 'package:chat_app/app/feature/splash/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState()) {
    init();
  }

  void init() {
    Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(loaded: true));
    });
  }
}
