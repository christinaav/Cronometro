import 'package:flutter/material.dart';
import 'dart:async';

//import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Stopwatch'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription f;
  Stream<int> stream;
  Text resume = Text('START');

  int _minutes = 0, _hours = 0, _counter = 0, tap = 0;
  String time = "00:00:00";
  String t_hours, t_minutes, t_seconds;
  bool isSwitched = true;
  Color col = Colors.white;

  convertTime() {
    setState(() {
      if (_counter == 60) {
        _counter = 0;
        _minutes++;
      }
      if (_counter < 10)
        t_seconds = '0$_counter';
      else
        t_seconds = _counter.toString();

      if (_minutes == 60) {
        _minutes = 0;
        _hours++;
      }

      if (_minutes < 10)
        t_minutes = '0$_minutes';
      else
        t_minutes = _minutes.toString();

      if (_hours < 10)
        t_hours = '0$_hours';
      else
        t_hours = _hours.toString();

      time = "$t_hours:$t_minutes:$t_seconds";
    });
  }

  startState() {
    resume = Text('RESUME');
    if (tap == 0) {
      stream = increment();
      f = stream.listen((_counter) => convertTime());
      tap++;
    }
    if (tap > 0 && f.isPaused) f.resume();
  }

  pauseState() {
    if (!f.isPaused) f.pause();
  }

  resumeState() {
    f.resume();
  }

  restartState() {
    if (!f.isPaused) f.pause();
    _counter = 0;
    _minutes = 0;
    _hours = 0;
    setState(() {
      time = "00:00:00";
    });
    resume = Text("START");
  }

  Stream<int> increment() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield _counter++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: col,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  print(value);
                  if (value)
                    col = Colors.black;
                  else
                    col = Colors.white;
                });
              },
              activeTrackColor: Colors.white,
              activeColor: Colors.teal,
            ),
          ],
        ),
        body: Center(
          child: Container(
            alignment: Alignment(0.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 120),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$time',
                      style: TextStyle(
                        fontSize: 85.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton.extended(
                      onPressed: startState,
                      icon: Icon(Icons.play_arrow),
                      label: resume,
                      backgroundColor: Colors.teal[400],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                    ),
                    FloatingActionButton.extended(
                      onPressed: pauseState,
                      icon: Icon(Icons.pause),
                      label: Text('PAUSE'),
                      backgroundColor: Colors.teal[400],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton.extended(
                      onPressed: restartState,
                      icon: Icon(Icons.loop),
                      label: Text('RESTART'),
                      backgroundColor: Colors.teal[400],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
