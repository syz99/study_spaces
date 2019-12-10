import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_spaces/components/close_button.dart';
import 'package:study_spaces/data_models/app_state.dart';
import 'package:study_spaces/data_models/reviews.dart';
import 'package:study_spaces/util/timer_text.dart';

class TimerPage extends StatefulWidget {
  TimerPage(this.space_id, this.userId);
  String space_id;
  String userId;

  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  Stopwatch stopwatch = new Stopwatch();
  int selectedProductivity = 0;
  int selectedStress = 0;
  int selectedNoise = 0;
  DateTime startTime;
  DateTime endTime;
  List<Productivity> prod = [Productivity.NOT_PRODUCTIVE, Productivity.PRODUCTIVE];
  List<NoiseLevel> noise = [NoiseLevel.LOW, NoiseLevel.AVERAGE, NoiseLevel.HIGH];
  List<StressLevel> stress = [StressLevel.LOW, StressLevel.AVERAGE, StressLevel.HIGH];

  void resetButton() {
    setState(() {
      if (stopwatch.isRunning) {
        //print("${stopwatch.elapsedMilliseconds}");
        //stopwatch.reset();
        //startTime = null;
      } else {
        stopwatch.reset();
        startTime = null;
        endTime = null;
      }
    });
  }

  void startButton() {
    setState(() {
      if (stopwatch.isRunning) {
        stopwatch.stop();
        endTime = new DateTime.now();
      } else {
        startTime = new DateTime.now();
        stopwatch.start();
      }
    });
  }

  void sendButton() {
    setState(() {
      if (stopwatch.isRunning) {
        print("${stopwatch.elapsedMilliseconds}");
      }
      else if (startTime != null && endTime != null) {
        //stopwatch.start();
        // OBTAIN THE STOPWATCH INTERVAL, GO TO FORM SECTION
        Review review = Review(
          id: "holder",
          productivity: prod[selectedProductivity],
          noiseLevel: noise[selectedNoise],
          stress: stress[selectedStress],
          startTime: startTime,
          endTime: endTime,
          spaceId: widget.space_id,
          userId: widget.userId
        );
        //state.addReview(review);
        // CONNECT TO FIRESTORE
        DocumentReference inst = Firestore.instance.collection('reviews').document();
        String id = inst.documentID;
        inst.setData({ 'endTime': review.endTime,
          'id': id,
          "startTime": review.startTime,
          "noiseLevel": review.noiseLevel.toString().split(".")[1],
          "stressLevel": review.stress.toString().split(".")[1],
          "productivity": review.productivity.toString().split(".")[1],
          "userId": review.userId,
          "spaceId": review.spaceId
        });
        Navigator.of(context).pop();

      }
    });
  }

  Widget buildFloatingButton(String text, Function callback) {
    TextStyle roundTextStyle =
    const TextStyle(fontSize: 25.0, color: Colors.white);
    return new FloatingActionButton(
        heroTag: text,
        child: new Text(text, style: roundTextStyle),
        onPressed: () => callback());
  }

  Widget createDropdown() {}

  @override
  Widget build(BuildContext context) {
    //final appState = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    return new CupertinoPageScaffold(
      backgroundColor: Colors.white,
        child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 0.0, top: 40.0, right: 350.0),
          child: CustomCloseButton(() {
            Navigator.of(context).pop();
          }),
        ),
        new Container(
            height: 100.0,
            child: new Center(
              child: new TimerText(stopwatch: stopwatch),
            )),
        new SizedBox(
          height: 150,
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new SizedBox(
                  height: 75,
                  width: 75,
                  child: Container(
                    //margin: EdgeInsets.only(left:80.0, top:80.0, bottom: 10.0) ,
                      child: buildFloatingButton(
                          stopwatch.isRunning ? "reset" : "reset",
                          resetButton)),
                ),
                new SizedBox(
                  height: 75,
                  width: 75,
                  child: Container(
                    //margin: EdgeInsets.only(left:80.0, top:80.0, bottom: 10.0) ,
                      child: buildFloatingButton(
                          stopwatch.isRunning ? "stop" : "start", startButton)),
                ),
              ]),
        ),
        new SizedBox(
          height: 150,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new SizedBox(
                height: 70,
                width: 100,
                child: new Text("Level of productivity:"),
              ),
          new SizedBox(
            height: 75,
            width: 100,
            child:          Container(
                child: CupertinoPicker(
                  magnification: 1.5,
                  backgroundColor: Colors.blueAccent,
                  children: <Widget>[
                    Text(
                      "LOW",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      "HIGH",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                  itemExtent: 50,
                  //height of each item
                  looping: false,
                  onSelectedItemChanged: (int index) {
                    selectedProductivity = index;
                  },
                ))
          )
          ],
          )
        ),
        new SizedBox(
            height: 150,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new SizedBox(
                  height: 70,
                  width: 100,
                  child: new Text("Level of stress:"),
                ),
                new SizedBox(
                    height: 75,
                    width: 100,
                    child:          Container(
                        child: CupertinoPicker(
                          magnification: 1.5,
                          backgroundColor: Colors.blueAccent,
                          children: <Widget>[
                            Text(
                              "LOW",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              "AVERAGE",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              "HIGH",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                          itemExtent: 50,
                          //height of each item
                          looping: false,
                          onSelectedItemChanged: (int index) {
                            selectedStress = index;
                          },
                        ))
                )
              ],
            )
        ),
        new SizedBox(
            height: 150,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new SizedBox(
                  height: 70,
                  width: 100,
                  child: new Text("Level of noise"),
                ),
                new SizedBox(
                    height: 75,
                    width: 100,
                    child:          Container(
                        child: CupertinoPicker(
                          magnification: 1.5,
                          backgroundColor: Colors.blueAccent,
                          children: <Widget>[
                            Text(
                              "LOW",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              "AVERAGE",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              "HIGH",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                          itemExtent: 50,
                          //height of each item
                          looping: false,
                          onSelectedItemChanged: (int index) {
                            selectedNoise= index;
                          },
                        ))
                )
              ],
            )
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
    )
    );
  }
}
