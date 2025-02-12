import 'package:chat_app/app/feature/auth/sign_in/login_screen.dart';
import 'package:chat_app/app/feature/auth/signup/register_screen.dart';
import 'package:chat_app/app/feature/welcom/welcome_screen.dart';
import 'package:chat_app/app/routes/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../feature/dashboard/main_dashboard/dashboard_screen.dart';
import '../feature/splash/splash_screen.dart';

class RouterClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => SignIn());
      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => const WelComeScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.dashBoard:
        return MaterialPageRoute(builder: (_) => const DashBoardScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
