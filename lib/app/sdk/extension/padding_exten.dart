import 'package:flutter/cupertino.dart';

extension PaddingExtension on Widget {
  Padding pad0({Key? key}) => Padding(
        key: key,
        padding: EdgeInsets.zero,
        child: this,
      );

  Padding padLTRB(
    double left,
    double right,
    double bottom,
    double top, {
    Key? key,
  }) =>
      Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: this,
      );

  Padding padSymetric(double hor, double ver, {Key? key}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: hor, vertical: ver),
        child: this,
      );

  Padding padOnly({
    Key? key,
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: this,
      );

  Padding padHor(double hor, {Key, key}) => Padding(
        key: key,
        padding: EdgeInsets.symmetric(horizontal: hor),
        child: this,
      );
  Padding padVar(double ver, {Key, key}) => Padding(
        key: key,
        padding: EdgeInsets.symmetric(vertical: ver),
        child: this,
      );
}
