//import 'dart:html';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

int nivel = 4;

class Home extends StatefulWidget {
  final int size;
  const Home({Key? key, this.size = 4}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  List<String> data = [];
  int previousIndex = -1;
  bool flip = false;
  int time = 0;
  var timer;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.size; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }
    for (var i = 0; i < widget.size / 2; i++) {
      data.add(i.toString());
      data.add(i.toString());
    }

    startTimer();
    data.shuffle();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Tiempo $time",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Theme(
              data: ThemeData.dark(),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (nivel / 2).toInt(),
                  ),
                  itemBuilder: (context, index) => FlipCard(
                    key: cardStateKeys[index],
                    onFlip: () {
                      print(data.length);
                      if (!flip) {
                        flip = true;
                        previousIndex = index;
                      } else {
                        flip = false;
                        if (previousIndex != index) {
                          if (data[previousIndex] != data[index]) {
                            cardStateKeys[previousIndex]
                                .currentState!
                                .toggleCard();
                            previousIndex = index;
                          } else {
                            cardFlips[previousIndex] = false;
                            cardFlips[index] = false;
                            print(cardFlips);

                            if (cardFlips.every((t) => t == false)) {
                              print("Bien hecho, siguiente nivel :) ");
                              showResult();
                            }
                          }
                        }
                      }
                    },
                    direction: FlipDirection.HORIZONTAL,
                    flipOnTouch: cardFlips[index],
                    front: Container(
                        margin: EdgeInsets.all(4.0),
                        color: Colors.greenAccent.withOpacity(0.3)),
                    back: Container(
                      margin: EdgeInsets.all(4.0),
                      color: Colors.pink.withOpacity(0.3),
                      child: Text(
                        "${data[index]}",
                        style: Theme.of(context).textTheme.display2,
                      ),
                    ),
                  ),
                  itemCount: data.length,
                ),
              ))
        ],
      ),
    )));
  }

  showResult() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text("ganaste"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Home(
                          size: nivel,
                        ),
                      ),
                    );
                    nivel = nivel + 2;
                  },
                  child: Text("siguiente"),
                ),
              ],
            ));
  }
}
