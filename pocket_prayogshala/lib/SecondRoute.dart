import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/rendering.dart';

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go To Previous Page'),
          //color: Colors.blue.shade900,
          //textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
