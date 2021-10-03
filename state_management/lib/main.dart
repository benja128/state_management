import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:state_management/helpers/property_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  debugRepaintRainbowEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PropertyNotifer())],
      child: MaterialApp(
        title: 'State Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'State Management'),
      ),
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
  PropertyNotifer propertyNotifier = PropertyNotifer();

  Timer _timer;
  int _start = 0;

  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 30) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start++;
            propertyNotifier.time++;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final PropertyNotifer notifer = Provider.of<PropertyNotifer>(context);
    if (notifer.map.isEmpty) {
      notifer.init();
    }
    propertyNotifier = notifer;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: notifer.map.length,
        itemBuilder: (context, index) {
          return new Text(
            notifer.map[index + 1].toString(),
            style: TextStyle(fontSize: 50.0),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startTimer(),
        child: Text('Start'),
      ),
    );
  }
}
