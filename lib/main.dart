import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  int _counter;
  Stream<int> stream;
  int _minutes = 0, _hours = 0;
  String time = "";

  convertTime() {
    if (_counter == 60) {
      _minutes++;
      _counter = 0;
    }
    if (_minutes == 60) {
      _hours++;
      _minutes = 0;
    }
    setState(() {
      time = "$_hours:$_minutes:$_counter";
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
            Text(
              'You have pushed the button this many times:',
            ),
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
        child: Icon(Icons.add),
      ),
    );
  }
}
