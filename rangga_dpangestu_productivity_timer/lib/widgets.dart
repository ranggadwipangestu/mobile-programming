// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;

  final VoidCallback onPressed;

  const ProductivityButton(
      {Key? key,
      required this.color,
      required this.text,
      this.size = 1,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      color: color,
      minWidth: size,
    );
  }
}

typedef CallbackSetting = void Function(String, int);

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;

  final int value;
  final String setting;
  final CallbackSetting callback;

  const SettingsButton(
      {Key? key,
      required this.color,
      required this.text,
      required this.size,
      required this.value,
      required this.setting,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: () => callback(setting, value),
      color: color,
      minWidth: size,
    );
  }
}
