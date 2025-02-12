import 'package:chat_app/app/sdk/style/color/color.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../style/size/size.dart';

class CustomReactiveFied extends StatelessWidget {
  const CustomReactiveFied(
      {super.key,
      required this.hintText,
      required this.formController,
      required this.validationMessage,
      required this.labal});
  final String formController;
  final String hintText;
  final String validationMessage;
  final String labal;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
        formControlName: formController,
        cursorColor: AppColor.primaryColor,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            hintText: hintText,
            label: Text(labal),
            counterStyle: const TextStyle(
                backgroundColor: AppColor.textColor,
                fontSize: Sizes.s16,
                color: AppColor.textPrimaryColor),
            errorMaxLines: 2,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppColor.primaryColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppColor.primaryColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppColor.primaryColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red))),
        validationMessages: {
          ValidationMessage.required: (error) => validationMessage,
        });
  }
}
