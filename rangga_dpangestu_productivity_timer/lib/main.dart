// ignore_for_file: unused_label

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rangga_dpangestu_productivity_timer/settings.dart';
import 'package:rangga_dpangestu_productivity_timer/timermodel.dart';
import 'package:rangga_dpangestu_productivity_timer/widgets.dart';

import 'timer.dart';

void main(List<String> args) => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rangga Work Timer',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const TimerHomepage());
  }
}

class TimerHomepage extends StatefulWidget {
  const TimerHomepage({Key? key}) : super(key: key);

  @override
  State<TimerHomepage> createState() => _TimerHomepageState();
}

class _TimerHomepageState extends State<TimerHomepage> {
  Color activeColor = Colors.indigo;
  Color inactiveColor = Colors.blue;

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

  final double defaultPadding = 5.0;

  final CountdownTimer timer = CountdownTimer();

  final List<PopupMenuItem<String>> menuItems = [];

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    menuItems
        .add(const PopupMenuItem(child: Text('Settings'), value: 'Settings'));
    //

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rangga Productivity Timer'),
        actions: [
          PopupMenuButton(
            itemBuilder: ((BuildContext context) => menuItems.toList()),
            onSelected: (value) {
              if (value == 'Settings') {
                goToSettings(context);
              }
            },
          )
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final double availableWidth = constraints.maxWidth;

        return Column(
          children: [
            //widget button diatas 🔽
            Row(
              children: [
                Padding(padding: EdgeInsets.all(defaultPadding)),
                Expanded(
                  child: ProductivityButton(
                      color: work ? activeColor : inactiveColor,
                      text: "Work",
                      onPressed: () {
                        timer.startWork();
                        updateStatus('work');
                      }),
                ),
                Padding(padding: EdgeInsets.all(defaultPadding)),
                Expanded(
                    child: ProductivityButton(
                        color: shortBreak ? activeColor : inactiveColor,
                        text: "Short Break",
                        onPressed: () {
                          timer.startBreak(true);
                          updateStatus('shortBreak');
                        })),
                Padding(padding: EdgeInsets.all(defaultPadding)),
                Expanded(
                    child: ProductivityButton(
                        color: longBreak ? activeColor : inactiveColor,
                        text: "Long Break",
                        onPressed: () {
                          timer.startBreak(false);
                          updateStatus('longBreak');
                        })),
                Padding(padding: EdgeInsets.all(defaultPadding)),
              ],
            ),
            StreamBuilder(
                initialData: '00:00',
                stream: timer.stream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  TimerModel timer = (snapshot.data == '00:00')
                      ? TimerModel('00:00', 1)
                      : snapshot.data;
                  return Expanded(
                    child: CircularPercentIndicator(
                      radius: availableWidth / 4,
                      circularStrokeCap: CircularStrokeCap.round,
                      lineWidth: 10,
                      percent: timer.percent,
                      progressColor: Colors.teal,
                      center: Text(timer.time,
                          style: Theme.of(context).textTheme.headline4),
                    ),
                  );
                }),

            //widget button bagian bawah 🔽
            Row(
              children: [
                Padding(padding: EdgeInsets.all(defaultPadding)),
                Expanded(
                    child: ProductivityButton(
                        color: Colors.indigoAccent,
                        text: "Start",
                        onPressed: () {
                          timer.startTimer();
                        })),
                Padding(padding: EdgeInsets.all(defaultPadding)),
                Expanded(
                    child: ProductivityButton(
                        color: Colors.indigoAccent,
                        text: "Stop",
                        onPressed: () => timer.stopTimer())),
                Padding(padding: EdgeInsets.all(defaultPadding)),
                Expanded(
                    child: ProductivityButton(
                        color: Colors.indigoAccent,
                        text: "Reset",
                        onPressed: () => timer.startWork())),
                Padding(padding: EdgeInsets.all(defaultPadding)),
              ],
            ),
          ],
        );
      }),
    );
  }

  // void showNow(color){
  void goToSettings(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }
}
