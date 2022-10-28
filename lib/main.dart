// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scratchnwin/CardModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scratch & Win',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Scratch & Win'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double turns = 0.0;
  List<CardModel> cardKeyArr = [];

  void changeRotation() {
    setState(() => turns += 1.0 / 4.0);
  }

  @override
  void initState() {
    resetDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                ),
                itemBuilder: (c, i) => FlipCard(
                  key: cardKeyArr[i].cardKey,
                  flipOnTouch: true,
                  onFlip: () async {
                    if (cardKeyArr[i].isGift) {
                      showToast(msg: "You Won The Game");
                      await Future.delayed(Duration(seconds: 1));
                      resetDetails();
                    }
                  },
                  front: showContainer(
                      isFront: true, isGift: cardKeyArr[i].isGift),
                  back: showContainer(
                      isFront: false, isGift: cardKeyArr[i].isGift),
                ),
                itemCount: 25,
              ),
            ),
            SizedBox(height: 50.0),
            FloatingActionButton.extended(
              onPressed: () => resetDetails(),
              label: Text("Refresh"),
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }

  showContainer({required bool isFront, required isGift}) {
    return Material(
      color: Colors.blue,
      child: isFront
          ? Icon(Icons.question_mark)
          : isGift
              ? Icon(Icons.celebration)
              : Icon(Icons.warning),
    );
  }

  int getRandomNum() {
    int randomNumber = Random().nextInt(25) + 1;
    print(randomNumber);
    return randomNumber;
  }

  void resetDetails() {
    int rndNum = getRandomNum();
    cardKeyArr = List.generate(25, (index) {
      GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

      return CardModel(cardKey: cardKey, isGift: index == rndNum);
    });
    changeRotation();
    setState(() {});
  }

  showToast({required msg}) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
