import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(color: color ?? Colors.white)));
  }
}
