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
  int _minutes = 0, _hours = 0, _counter;
  String time = "00:00:00";
  String t_hours, t_minutes, t_seconds;

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

  changeState() {
    stream = increment();
    f = stream.listen((_counter) => convertTime());
  }

  stopState() {
    f.pause();
  }

  resumeState() {
    f.resume();
  }

  Stream<int> increment() async* {
    _counter = 0;
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield _counter++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: <Widget>[
                Text(
                  '$time',
                  style: TextStyle(
                    fontSize: 70.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: changeState,
                  icon: Icon(Icons.play_arrow),
                  label: Text('START'),
                  backgroundColor: Colors.teal[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: stopState,
                  icon: Icon(Icons.pause),
                  label: Text('PAUSE'),
                  backgroundColor: Colors.teal[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: null,
                  icon: Icon(Icons.loop),
                  label: Text('RESTART'),
                  backgroundColor: Colors.teal[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
