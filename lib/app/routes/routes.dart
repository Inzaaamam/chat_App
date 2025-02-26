import 'package:chat_app/app/feature/auth/sign_in/login_screen.dart';
import 'package:chat_app/app/feature/auth/signup/register_screen.dart';
import 'package:chat_app/app/feature/dashboard/chat/chat_screen.dart';
import 'package:chat_app/app/feature/dashboard/main_screen/main_screen.dart';
import 'package:chat_app/app/feature/welcom/welcome_screen.dart';
import 'package:chat_app/app/routes/constant.dart';
import 'package:flutter/material.dart';

import '../feature/dashboard/main_dashboard/dashboard_screen.dart';
import '../feature/splash/splash_screen.dart';

class RouterClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => const WelComeScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.dashBoard:
        return MaterialPageRoute(builder: (_) => DashBoardScreen());
      case AppRoutes.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case AppRoutes.chatScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args != null && args.containsKey('uid') && args.containsKey('email')) {
          return MaterialPageRoute(
            builder: (_) => ChatScreen(
              receiverId: args['uid'],
              receiverEmail: args['email'],
            ),
          );
        }
        return _errorRoute(settings.name);
      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for $routeName')),
      ),
    );
  }
}
