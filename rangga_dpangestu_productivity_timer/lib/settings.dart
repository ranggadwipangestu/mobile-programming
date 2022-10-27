// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextStyle textStyle = const TextStyle(fontSize: 20);

  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;

  static const String WORKTIME = 'workTime';
  static const String SHORTBREAK = 'shortBreak';
  static const String LONGBREAK = 'longBreak';

  int workTime = 0;
  int shortBreak = 0;
  int longBreak = 0;

  late SharedPreferences prefs;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          Text(
            'Work',
            style: textStyle,
          ),
          const Text(''),
          const Text(''),
          SettingsButton(
            color: Colors.blue,
            text: ('-'),
            size: 5,
            value: -1,
            setting: WORKTIME,
            callback: updateSettings,
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork,
          ),
          SettingsButton(
            color: Colors.indigo,
            text: ('+'),
            size: 5,
            value: 1,
            setting: WORKTIME,
            callback: updateSettings,
          ),
          Text(
            'Short',
            style: textStyle,
          ),
          const Text(''),
          const Text(''),
          SettingsButton(
            color: Colors.blue,
            text: ('-'),
            size: 5,
            value: -1,
            setting: SHORTBREAK,
            callback: updateSettings,
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtShort,
          ),
          SettingsButton(
            color: Colors.indigo,
            text: ('+'),
            size: 5,
            value: 1,
            setting: SHORTBREAK,
            callback: updateSettings,
          ),
          Text(
            'Long',
            style: textStyle,
          ),
          const Text(''),
          const Text(''),
          SettingsButton(
            color: Colors.blue,
            text: ('-'),
            size: 5,
            value: -1,
            setting: LONGBREAK,
            callback: updateSettings,
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtLong,
          ),
          SettingsButton(
            color: Colors.indigo,
            text: ('+'),
            size: 5,
            value: 1,
            setting: LONGBREAK,
            callback: updateSettings,
          )
        ],
        padding: const EdgeInsets.all(20),
      ),
    );
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      await prefs.setInt(WORKTIME, 30);
    }
    int? shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs.setInt(SHORTBREAK, 5);
    }
    int? longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs.setInt(LONGBREAK, 20);
    }

    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSettings(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int workTime = prefs.getInt(WORKTIME)!;
          workTime += value;
          if (workTime >= 1 && workTime <= 120) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = prefs.getInt(SHORTBREAK)!;
          short += value;
          if (short >= 1 && short <= 120) {
            prefs.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = prefs.getInt(LONGBREAK)!;
          long += value;
          if (long >= 1 && long <= 120) {
            prefs.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}
