import 'package:chat_app/app/sdk/style/color/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/size/size.dart';

class CustomFillButton extends StatelessWidget {
  const CustomFillButton(
      {super.key,
      required this.isloading,
      required this.label,
      required this.onTap,
      required this.color,
      required this.size,
      required this.height});
  final bool isloading;
  final String label;
  final VoidCallback onTap;
  final Color color;
  final double size;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: FilledButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => color),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.s30),
            ),
          ),
        ),
        child: isloading
            ? const SizedBox(
                height: Sizes.s28,
                width: Sizes.s28,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColor.textColor,
                  ),
                ),
              )
            : Text(
                label,
                style: TextStyle(color: AppColor.textColor, fontSize: size),
              ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onTap,
      required this.color,
      required this.size,
      required this.height,
      required this.childWidget});
  final VoidCallback onTap;
  final Color color;
  final double size;
  final double height;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: FilledButton(
          onPressed: onTap,
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => color),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.s30),
              ),
            ),
          ),
          child: childWidget),
    );
  }
}
