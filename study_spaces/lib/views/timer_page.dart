import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_spaces/components/close_button.dart';
import 'package:study_spaces/util/timer_text.dart';

class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);

  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  Stopwatch stopwatch = new Stopwatch();

  void resetButton() {
    setState(() {
      if (stopwatch.isRunning) {
        //print("${stopwatch.elapsedMilliseconds}");
        stopwatch.reset();
      } else {
        stopwatch.reset();
      }
    });
  }

  void startButton() {
    setState(() {
      if (stopwatch.isRunning) {
        stopwatch.stop();
      } else {
        stopwatch.start();
      }
    });
  }

  void sendButton() {
    setState(() {
      if (stopwatch.isRunning) {
        print("${stopwatch.elapsedMilliseconds}");
      } else {
        //stopwatch.start();
        // OBTAIN THE STOPWATCH INTERVAL, GO TO FORM SECTION
      }
    });
  }

  Widget buildFloatingButton(String text, VoidCallback callback) {
    TextStyle roundTextStyle =
        const TextStyle(fontSize: 25.0, color: Colors.white);
    return new FloatingActionButton(
        heroTag: text,
        child: new Text(text, style: roundTextStyle),
        onPressed: callback);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left:0.0, top:40.0, right: 350.0) ,
          child:  CustomCloseButton(() {
            Navigator.of(context).pop();
          }),
        ),
        new Container(
            height: 200.0,
            child: new Center(
              child: new TimerText(stopwatch: stopwatch),
            )),
        new SizedBox(
          height: 200,
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new SizedBox(
                  height: 100,
                  width: 100,
                  child: Container(
                      //margin: EdgeInsets.only(left:80.0, top:80.0, bottom: 10.0) ,
                      child: buildFloatingButton(
                          stopwatch.isRunning ? "reset" : "reset", resetButton)),
                ),
                new SizedBox(
                  height: 100,
                  width: 100,
                  child: Container(
                      //margin: EdgeInsets.only(left:80.0, top:80.0, bottom: 10.0) ,
                      child: buildFloatingButton(
                          stopwatch.isRunning ? "stop" : "start", startButton)),
                ),
              ]),
        ),
        new SizedBox(
          height: 100,
          width: 120,
          child: Container(
              //margin: EdgeInsets.only(left:80.0, top:80.0, bottom: 10.0) ,
              child: buildFloatingButton(
                  stopwatch.isRunning ? "submit" : "submit", sendButton)),
        ),
      ],
    );
  }
}
