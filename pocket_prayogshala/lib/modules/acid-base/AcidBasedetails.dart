import 'package:pocket_prayogshala/modules/acid-base/acidbase.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/rendering.dart';
import '../../aboutUs.dart';
import '../../mycolors.dart';

class AcidBasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var moduleThumbnail = InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => acidBase()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(color: Color.fromARGB(255, 234, 228, 228)),
          child: Image.asset(
            'assets/images/acidbasethumbnail.png',
          ),
        ));
    var detailsArea = Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(color: Colors.yellow),
      ),
    );

    var instructionsText = Expanded(
        flex: 1,
        child: Container(
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 211, 220, 129)),
            child: Text('AcidBase')));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: appBarBg,
        elevation: 8,
        shadowColor: appBarShadow,
        title: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Tooltip(
            message: 'Home',
            child: Image(
              image: const AssetImage('assets/images/logo.png'),
              fit: BoxFit.contain,
              height: AppBar().preferredSize.height,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                moduleThumbnail,
                instructionsText,
              ],
            ),
            detailsArea,
          ],
        ),
      ),
    );
  }
}
