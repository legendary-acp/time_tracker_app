import 'package:flutter/material.dart';

// ignore: camel_case_types
class signin_custom_button extends StatelessWidget {
  signin_custom_button({
    this.child,
    this.color,
    this.radius = 4.0,
    this.onpress,
    this.height = 50.0,
  });
  final double height;
  final Widget child;
  final Color color;
  final double radius;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.height,
      child: RaisedButton(
        onPressed: this.onpress,
        color: this.color,
        child: this.child,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(this.radius),
          ),
        ),
      ),
    );
  }
}

