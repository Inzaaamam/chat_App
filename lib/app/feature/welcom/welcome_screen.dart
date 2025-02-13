import 'package:chat_app/app/routes/constant.dart';
import 'package:chat_app/app/sdk/extension/extension.dart';
import 'package:chat_app/app/sdk/extension/padding_exten.dart';
import 'package:chat_app/app/sdk/style/color/color.dart';
import 'package:flutter/material.dart';
import '../../sdk/widget/primary_button.dart';

class WelComeScreen extends StatelessWidget {
  const WelComeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.primaryBackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomFillButton(
                    height: 30,
                    color: AppColor.primaryColor,
                    isloading: false,
                    label: ''
                        'Skip',
                    size: 14,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.login);
                    },
                  ).padOnly(left: 20, right: 20, top: 80, bottom: 0)
                ],
              ),
              Image.asset('welcom'.pngImage),
              const Center(
                child: Text(
                  'Welcome to chatboat, a great friend to chat with you',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.textPrimaryColor,
                  ),
                ),
              ).padSymetric(80, 13),
              Row(
                children: [
                  Expanded(
                    child: CustomFillButton(
                      height: 50,
                      color: AppColor.primaryColor,
                      isloading: false,
                      label: ''
                          'Next',
                      size: 18,
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.login);
                      },
                    ).padOnly(left: 20, right: 20, top: 80, bottom: 0),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
