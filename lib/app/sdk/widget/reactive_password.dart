import 'package:chat_app/app/feature/auth/signup/register_cubit.dart';
import 'package:chat_app/app/feature/auth/signup/register_state.dart';
import 'package:chat_app/app/sdk/style/color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../style/size/size.dart';

class CustomReactivePasswordField extends StatelessWidget {
  const CustomReactivePasswordField({
    super.key,
    required this.hintText,
    required this.formController,
    required this.validationMessage,
    required this.label,
  });

  final String formController;
  final String hintText;
  final String validationMessage;
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: BlocSelector<RegisterCubit, RegisterState, bool?>(
        selector: (state) => state.isVisible,
        builder: (context, obscureText) {
          return ReactiveTextField(
            formControlName: formController,
            cursorColor: AppColor.primaryColor,
            obscureText: obscureText!,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              hintText: hintText,
              label: Text(label),
              counterStyle: const TextStyle(
                backgroundColor: AppColor.textColor,
                fontSize: Sizes.s16,
                color: AppColor.textPrimaryColor,
              ),
              errorMaxLines: 2,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppColor.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppColor.primaryColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppColor.primaryColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red),
              ),
              suffixIcon: IconButton(
                highlightColor: Colors.transparent,
                icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  context.read<RegisterCubit>().togglePassword();
                },
              ),
            ),
            validationMessages: {
              ValidationMessage.required: (error) => validationMessage,
            },
          );
        },
      ),
    );
  }
}
