import 'package:flutter/material.dart';
import 'package:rangga_dpangestu_pong_game/pong.dart';

void main(List<String> args) => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pong Demo Rangga',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Simple Pong Rangga'),
        ),
        body: const SafeArea(
          child: Pong(),
        ),
      ),
    );
  }
}
