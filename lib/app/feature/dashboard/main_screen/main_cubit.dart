import 'package:bloc/bloc.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());
  void selectIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
