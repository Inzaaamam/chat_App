import 'package:chat_app/app/feature/auth/sign_in/sign_cubit.dart';
import 'package:chat_app/app/feature/auth/sign_in/sign_state.dart';
import 'package:chat_app/app/sdk/extension/padding_exten.dart';
import 'package:chat_app/app/sdk/form/login_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../routes/constant.dart';
import '../../../sdk/enum/loading_status.dart';
import '../../../sdk/style/color/color.dart';
import '../../../sdk/style/size/size.dart';
import '../../../sdk/widget/primary_button.dart';
import '../../../sdk/widget/reactive_password.dart';
import '../../../sdk/widget/reactive_text_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final form = LoginForm.loginForm;
    return BlocProvider(
      create: (context) => SignCubit(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            toolbarHeight: 40,
            iconTheme: const IconThemeData(color: AppColor.textColor),
            backgroundColor: AppColor.primaryColor,
          ),
          body: SingleChildScrollView(
            child: BlocListener<SignCubit, SignState>(
              listener: (context, state) {
                if (state.status == Status.loaded) {
                  Navigator.of(context).pushNamed(AppRoutes.dashBoard);
                } else if (state.status == Status.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid Credentials'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: BlocBuilder<SignCubit, SignState>(
                builder: (context, state) {
                  return ReactiveForm(
                    formGroup: form,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Login',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: AppColor.textColor, fontSize: 30),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Enter Email and Password for login',
                                          style: TextStyle(
                                              color: AppColor.textColor, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            const CustomReactiveFied(
                              hintText: 'Enter your Email',
                              formController: 'email',
                              validationMessage: 'Enter valid Email',
                              labal: 'Enter your Email',
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const CustomReactivePasswordField(
                              hintText: 'Enter Password',
                              formController: 'password',
                              validationMessage: 'Enter Password',
                              label: 'Enter Password',
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                      childWidget: state.status == Status.isLoading
                                          ? const SizedBox(
                                              height: Sizes.s28,
                                              width: Sizes.s28,
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  color: AppColor.textColor,
                                                ),
                                              ),
                                            )
                                          : const Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: AppColor.textColor,
                                                  fontSize: 16),
                                            ),
                                      onTap: () {
                                        if (form.valid) {
                                          String email = form.control('email').value;
                                          String password =
                                              form.control('password').value;
                                          context
                                              .read<SignCubit>()
                                              .login(email, password);
                                        } else {
                                          form.markAllAsTouched();
                                        }
                                      },
                                      color: AppColor.primaryColor,
                                      size: 18,
                                      height: 50),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Dont have an account?",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    children: [
                                      TextSpan(
                                        text: ' Register',
                                        style: const TextStyle(
                                            color: AppColor.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context)
                                                .pushNamed(AppRoutes.signup);
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ).padSymetric(20, 30)
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
