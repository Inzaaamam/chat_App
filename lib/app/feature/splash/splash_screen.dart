import 'package:chat_app/app/sdk/extension/extension.dart';
import 'package:chat_app/app/sdk/style/color/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../routes/constant.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(const Duration(seconds: 1), () {
              if (snapshot.hasData && snapshot.data != null) {
                Navigator.pushReplacementNamed(context, AppRoutes.mainScreen);
              } else {
                Navigator.pushReplacementNamed(context, AppRoutes.welcome);
              }
            });
          });
          return Center(
            child: Image.asset('icon'.pngImage),
          );
        },
      ),
    );
  }
}
