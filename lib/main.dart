// ignore_for_file: prefer_const_constructors

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
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
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  void changeRotation() {
    setState(() => turns += 1.0 / 4.0);
  }

  @override
  void initState() {
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
                  key: GlobalKey<FlipCardState>(),
                  flipOnTouch: true,
                  front: Container(
                    color: Colors.blue,
                    child: Icon(Icons.question_mark),
                  ),
                  back: Container(
                    color: Colors.blue,
                    child: Icon(Icons.question_mark),
                  ),
                ),
                itemCount: 25,
              ),
            ),
            SizedBox(height: 50.0),
            FloatingActionButton.extended(
              onPressed: () {},
              label: Text("Refresh"),
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}
