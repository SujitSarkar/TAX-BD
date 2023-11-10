import 'package:flutter/Material.dart';

import '../../constant/app_color.dart';

class NormalCard extends StatelessWidget {
  const NormalCard(
      {Key? key,
      required this.child,
      this.bgColor,
      this.borderRadius,
      this.padding,
      this.onTap,this.width})
      : super(key: key);
  final Widget child;
  final Color? bgColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor ?? AppColor.cardColor,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
      elevation: 0.0,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.green.shade800,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
        child: Container(
          width: width,
          padding: padding ?? const EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
          ),
          child: child,
        ),
      ),
    );
  }
}
