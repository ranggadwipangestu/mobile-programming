import 'package:flutter/material.dart';

class ButtonState extends StatefulWidget {
  const ButtonState({Key? key}) : super(key: key);

  @override
  State<ButtonState> createState() => _ButtonStateState();
}

class _ButtonStateState extends State<ButtonState> {
  Color activeColor = Colors.purple;
  Color inactiveColor = Colors.grey;

  late bool work;
  late bool shortBreak;
  late bool longBreak;

  void updateStatus(String from) {
    if (from == 'work') {
      setState(() {
        work = true;
        shortBreak = false;
        longBreak = false;
      });
    } else if (from == 'shortBreak') {
      setState(() {
        work = false;
        shortBreak = true;
        longBreak = false;
      });
    } else if (from == 'longBreak') {
      setState(() {
        work = false;
        shortBreak = false;
        longBreak = true;
      });
    }
  }

  @override
  void initState() {
    work = true;
    shortBreak = false;
    longBreak = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Test swap button color'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                const Padding(padding: EdgeInsets.all(2)),
                Expanded(
                    child: MaterialButton(
                        color: work ? activeColor : inactiveColor,
                        child: const Text("Work"),
                        onPressed: () => updateStatus('work'))),
                const Padding(padding: EdgeInsets.all(2)),
                Expanded(
                    child: MaterialButton(
                        color: shortBreak ? activeColor : inactiveColor,
                        child: const Text("Short Break"),
                        onPressed: () => updateStatus('shortBreak'))),
                const Padding(padding: EdgeInsets.all(2)),
                Expanded(
                    child: MaterialButton(
                        color: longBreak ? activeColor : inactiveColor,
                        child: const Text("Long Break"),
                        onPressed: () => updateStatus('longBreak'))),
                const Padding(padding: EdgeInsets.all(2)),
              ],
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.all(2)),
                Expanded(
                    child: MaterialButton(
                        color: work ? activeColor : inactiveColor,
                        child: const Text("Work"),
                        onPressed: () => updateStatus('work'))),
                const Padding(padding: EdgeInsets.all(2)),
                Expanded(
                    child: MaterialButton(
                        color: shortBreak ? activeColor : inactiveColor,
                        child: const Text("Short Break"),
                        onPressed: () => updateStatus('shortBreak'))),
                const Padding(padding: EdgeInsets.all(2)),
                Expanded(
                    child: MaterialButton(
                        color: longBreak ? activeColor : inactiveColor,
                        child: const Text("Long Break"),
                        onPressed: () => updateStatus('longBreak'))),
                const Padding(padding: EdgeInsets.all(2)),
              ],
            ),
          ],
        ));
  }
}
