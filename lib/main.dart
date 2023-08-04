import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
void main() {

  runApp(const MyApp());
  windowManager.setAsFrameless();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My First App'),
        ),
        body: const Center(
          child: Column(children: [WindowTitleBarBox(
            ,
          )]),
        ),
      ),
    );
  }
}


class WindowButtons{

}