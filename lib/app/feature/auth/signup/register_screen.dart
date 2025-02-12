import 'package:chat_app/app/feature/auth/signup/register_cubit.dart';
import 'package:chat_app/app/feature/auth/signup/register_state.dart';
import 'package:chat_app/app/routes/constant.dart';
import 'package:chat_app/app/sdk/extension/padding_exten.dart';
import 'package:chat_app/app/sdk/style/color/color.dart';
import 'package:chat_app/app/sdk/widget/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../sdk/enum/loading_status.dart';
import '../../../sdk/form/signup_form.dart';
import '../../../sdk/style/size/size.dart';
import '../../../sdk/widget/reactive_password.dart';
import '../../../sdk/widget/reactive_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final form = SignUpForm.registerForm;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              toolbarHeight: 40,
              iconTheme: const IconThemeData(color: AppColor.textColor),
              backgroundColor: AppColor.primaryColor,
            ),
            body: SingleChildScrollView(
              child: BlocListener<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state.status == Status.loaded) {
                    Navigator.of(context).pushNamed(AppRoutes.login);
                  } else if (state.status == Status.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage.toString()),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                child: BlocBuilder<RegisterCubit, RegisterState>(
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
                                            'Register',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: AppColor.textColor, fontSize: 30),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Fill up your details to register',
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
                                height: 25,
                              ),
                              const CustomReactivePasswordField(
                                hintText: 'Enter Confirm Password',
                                formController: 'confirm_password',
                                validationMessage: 'Password must be match',
                                label: 'Enter Confirm Password',
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
                                                'Register',
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
                                                .read<RegisterCubit>()
                                                .registerAccount(email, password);
                                            // Navigator.of(context).pushNamed(AppRoutes.login);
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
                                      text: "Already have an account?",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      children: [
                                        TextSpan(
                                          text: ' Login',
                                          style: const TextStyle(
                                              color: AppColor.primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.of(context)
                                                  .pushNamed(AppRoutes.login);
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
            ));
      }),
    );
  }
}
