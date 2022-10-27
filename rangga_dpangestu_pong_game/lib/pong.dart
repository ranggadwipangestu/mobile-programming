// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rangga_dpangestu_pong_game/ball.dart';
import 'package:rangga_dpangestu_pong_game/bat.dart';

enum Direction { up, down, left, right } //mendeklarasikan arah

class Pong extends StatefulWidget {
  const Pong({Key? key}) : super(key: key);

  @override
  State<Pong> createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  // turunan dari class lain (with)
  int score = 0;

  double randomNumber() {
    var ran = Random();
    //random number antara 0,5 dan 1,5
    int myNum = ran.nextInt(101);
    return (50 + myNum) / 100;
  }

  double randX = 1;
  double randY = 1;

  //hanya ada dua arah tapi 4 kemungkinan
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;

  late double width;
  late double height;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;

  late Animation<double> animation;
  late AnimationController controller;

  double increment = 1;

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controller = AnimationController(
      duration: const Duration(minutes: 10000),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      safeSetState(() {
        (hDir == Direction.right)
            ? posX += ((increment * randX).round())
            : posX -= ((increment * randX).round());
        (vDir == Direction.down)
            ? posY += ((increment * randY).round())
            : posY -= ((increment * randY).round());
      });
      checkBorders();
    });
    controller.forward(); //untuk memulai animasi nya
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      height = constraints.maxHeight; //dapatkan dulu tinggi layar nya
      width = constraints.maxWidth;
      batWidth = width / 2;
      batHeight = height / 25;
      return Stack(
        children: [
          Positioned(
            top: 10,
            right: 25,
            child: Text('Score : $score'),
          ),
          Positioned(
            top: 10,
            right: 90,
            child: Text('Increment : $increment'),
          ),
          Positioned(
            top: posY,
            left: posX,
            child: const Ball(),
          ),
          Positioned(
              bottom: 0,
              left: batPosition,
              child: GestureDetector(
                  onHorizontalDragUpdate: (DragUpdateDetails update) =>
                      moveBat(update),
                  child: Bat(width: batWidth, height: batHeight))),
        ],
      );
    });
  }

  void checkBorders() {
    //kiri
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      randX = randomNumber();
    }
    //kanan
    if (posX >= width - Ball.diameter && hDir == Direction.right) {
      hDir = Direction.left;
      randX = randomNumber();
    }
    //bawah
    if (posY >= height - Ball.diameter - batHeight && vDir == Direction.down) {
      //cek apakah terkena bat jika tidak, kalah
      if (posX >= (batPosition - (Ball.diameter / 2)) &&
          posX <= (batPosition + batWidth + (Ball.diameter / 2))) {
        vDir = Direction.up;
        randY = randomNumber();
        safeSetState(() {
          score++;
          increment += 0.5;
        });
      } else {
        controller.stop();

        showMessage(context);
      }
    }
    //atas
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
      randY = randomNumber();
    }
  }

  void moveBat(DragUpdateDetails update) {
    safeSetState(() {
      batPosition += update.delta.dx;
      if (batPosition <= 0) {
        batPosition = 0;
      } else if (batPosition >= width - batWidth) {
        batPosition = width - batWidth;
      }
      //dx=perubahan secara horizontal
    });
  }

  void safeSetState(Function function) {
    //di cek dulu apakah bisa di setState

    if (mounted && controller.isAnimating) {
      setState(() {
        function();
      });
    }
  }

  void showMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Over'),
            content: const Text('Apakah anda ingin bermain lagi?'),
            actions: <Widget>[
              FlatButton(
                child: const Text('Ya'),
                onPressed: () {
                  setState(() {
                    posX = 0;
                    posY = 0;
                    score = 0;
                    increment = 1;
                  });
                  Navigator.of(context).pop();
                  controller.repeat();
                },
              ),
              FlatButton(
                  child: const Text('Tidak'),
                  onPressed: () {
                    SystemNavigator.pop();
                    dispose();
                  }),
            ],
          );
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
