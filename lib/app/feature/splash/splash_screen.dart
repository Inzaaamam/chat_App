import 'package:chat_app/app/feature/splash/splash_cubit.dart';
import 'package:chat_app/app/feature/splash/splash_state.dart';
import 'package:chat_app/app/sdk/extension/extension.dart';
import 'package:chat_app/app/sdk/style/color/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routes/constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state.loaded!) {
              Navigator.pushNamed(context, AppRoutes.welcome);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset('icon'.pngImage),
              )
            ],
          ),
        ),
      ),
    );
  }
}
