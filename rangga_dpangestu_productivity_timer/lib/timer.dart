import 'dart:async';

import 'package:rangga_dpangestu_productivity_timer/timermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountdownTimer {
  double _percent = 1;
  bool _isActive = true;
  // Timer timer;
  Duration? _time; // tanda tanya, tidak masalah jika _time tidak ada isinya
  Duration? _fullTime; // _fulltime waktu awal, _time waktu saat ini
  int work = 0;
  int shortBreak = 0;
  int longBreak = 0;

  void startWork() async {
    await readSettings();
    _percent = 1;
    _time = Duration(minutes: work, seconds: 0);
    _fullTime = _time;
  }

  void stopTimer() {
    _isActive = false;
  }

  void startTimer() {
    if (_time!.inSeconds > 0) {
      _isActive = true;
    }
  }

  void startBreak(bool isShort) async {
    await readSettings();
    _percent = 1;
    _time = Duration(minutes: isShort ? shortBreak : longBreak);
    _fullTime = _time;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int a) {
      // generator function >> yield seperti return, pemanggilan yang berulang kali, berbeda dengan return yang setelah dipanggil lalu exit
      String time;
      if (_isActive) {
        // tanda seru, jika nilai _time tidak null maka akan beroperasi
        _time = _time! - const Duration(seconds: 1);
        // fungsi akan terus looping hingga _time! - const Duration(seconds: 1); bernilai 0 dan membuat isActive = false
        _percent = _time!.inSeconds / _fullTime!.inSeconds;
        if (_time!.inSeconds <= 0) {
          _isActive = false;
          //setelah isActive false fungsi akan dilanjutkan dibawah
        }
      }
      time = returnTime(_time!); // time menjadi 00:00
      return TimerModel(time, _percent);
    });
  }

  String returnTime(Duration t) {
    String minutes = t.inMinutes < 10
        ? '0' +
            t.inMinutes
                .toString() //jika nilai inminutes < 0 maka akan ditambahkan nilai 0 dibelakangnya hingga akan menjadi 09 08 07 06 dst
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        numSeconds < 10 ? '0' + numSeconds.toString() : numSeconds.toString();
    return "$minutes: $seconds";
  }

  Future readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = prefs.getInt('workTime') ?? 30;
    shortBreak = prefs.getInt('shortBreak') ?? 10;
    longBreak = prefs.getInt('longBreak') ?? 20;
  }
}
