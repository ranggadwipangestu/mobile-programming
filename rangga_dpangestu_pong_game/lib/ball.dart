import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  static double diameter = 50;
  const Ball({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const double diameter = 30;
    return Container(
      width: diameter,
      height: diameter,
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
        shape: BoxShape.circle,
      ),
    );
  }
}
