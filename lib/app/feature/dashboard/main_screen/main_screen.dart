import 'package:chat_app/app/feature/dashboard/main_dashboard/dashboard_screen.dart';
import 'package:chat_app/app/feature/splash/splash_screen.dart';
import 'package:chat_app/app/sdk/style/color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_cubit.dart';
import 'main_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static List<Widget> widgetOptions = [
    DashBoardScreen(),
    const SplashScreen(),
    const SplashScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BlocProvider(
        create: (context) => MainCubit(),
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return Scaffold(
                bottomNavigationBar: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
                    useLegacyColorScheme: true,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: AppColor.primaryColor,
                    unselectedItemColor: Colors.blueGrey,
                    currentIndex: state.selectedIndex,
                    onTap: (index) => context.read<MainCubit>().selectIndex(index),
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: Icon(Icons.chat),
                        label: 'Chats',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: Icon(Icons.person),
                        label: 'Contact',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: Icon(Icons.settings),
                        label: 'Settings',
                      ),
                    ],
                  ),
                ),
                body: widgetOptions.elementAt(state.selectedIndex));
          },
        ),
      ),
    );
  }
}
