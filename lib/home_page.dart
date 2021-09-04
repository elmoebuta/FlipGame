//import 'dart:html';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int time = 0;
  var timer;

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Tiempo $time",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) => FlipCard(
                onFlip: () {},
                direction: FlipDirection.HORIZONTAL,
                flipOnTouch: true,
                front: Container(
                    margin: EdgeInsets.all(4.0),
                    color: Colors.greenAccent.withOpacity(0.3)),
                back: Container(
                  child: Center(child: Image.asset("assetsGame/dino.png")),
                ),
              ),
              itemCount: 6,
            ),
          )
        ],
      ),
    )));
  }
}
