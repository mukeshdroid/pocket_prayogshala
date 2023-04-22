import 'package:first_app_flutter/modules/lever1/lever1.dart';
import 'package:first_app_flutter/ui.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'SecondRoute.dart';

class MyHoverCard extends StatefulWidget {
  MyHoverCard({super.key, this.title = "default", required this.imagesrc});

  String title = 'hello';
  String textBanner = 'Comming Soon! Stay Tuned.';
  String imagesrc = '';
  bool isImplemented = false;

  @override
  State<MyHoverCard> createState() => _MyHoverCardState();
}

class _MyHoverCardState extends State<MyHoverCard> {
  bool selected = false;
  bool isHover = false;

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    var imageStack = Stack(
      children: <Widget>[
        Expanded(
            child: Image.asset(
          'assets/images/${widget.imagesrc}',
          fit: BoxFit.cover,
        )),
        Positioned(
            child: Text(
          (isHover && !widget.isImplemented) ? widget.textBanner : '',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontFamily: 'Open Sans',
              fontSize: 40),
        )),
      ],
    );

    return Container(
      child: Center(
        child: AnimatedContainer(
          height: (isHover) ? 400 : 300,
          width: (isHover) ? 400 : 300,
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.only(
              top: (isHover) ? 25 : 30.0, bottom: !(isHover) ? 25 : 30),
          child: Container(
            color: Colors.blue,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondRoute()));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  imageStack,
                  Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onHover: (val) {
                print("Val--->{}$val");
                setState(() {
                  isHover = val;
                });
              },
            ),
          ),
          /*val--->true when user brings in mouse
           val---> false when brings out his mouse*/
        ),
      ),
    );
  }
}
