import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title: 'My first stopwatch'),
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
    stream = increment(Duration(seconds: 1));
    stream.listen((_counter) => convertTime());
  }

  Stream<int> increment(Duration interval) async* {
    _counter = 0;
    while (true) {
      await Future.delayed(interval);
      yield _counter++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('🧜'),
              Text(
                '$time',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: changeState,
          tooltip: 'Increment',
          child: Text('🥦'),
          backgroundColor: Colors.cyan,
        ));
  }
}
