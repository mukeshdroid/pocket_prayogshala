import 'package:pocket_prayogshala/modules/lever1/lever1.dart';
import 'package:pocket_prayogshala/ui.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'ComingSoon.dart';

class MyHoverCard extends StatefulWidget {
  MyHoverCard(
      {super.key,
      this.title = "default",
      required this.imagesrc,
      this.isImplemented = false,
      required this.redirect});

  String title;
  String textBanner = 'Comming Soon! Stay Tuned.';
  String imagesrc = '';
  bool isImplemented;
  dynamic redirect;

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
              fontSize: 30),
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
              top: (isHover) ? 10 : 20.0, bottom: !(isHover) ? 10 : 20),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20), bottom: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 18, 16, 16),
                  offset: Offset(5, 10),
                  blurRadius: 30,
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => widget.redirect));
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
                setState(() {
                  isHover = val;
                  //print(widget.isImplemented);
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
