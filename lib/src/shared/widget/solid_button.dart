import 'package:flutter/material.dart';
import '../../constant/app_color.dart';

class SolidButton extends StatelessWidget {
  const SolidButton(
      {Key? key,
      required this.onTap,
      required this.child,
      this.width,
      this.backgroundColor})
      : super(key: key);
  final Function() onTap;
  final Widget child;
  final double? width;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColor.primaryColor,
            elevation: 0.0,
            fixedSize: Size(width ?? MediaQuery.of(context).size.width, 45),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
        onPressed: onTap,
        child: child);
  }
}
