import 'package:flutter/material.dart';

class MyHoverCard extends StatefulWidget {
  MyHoverCard({super.key, this.title = "default"});

  String title = 'hello';
  bool selected = false;
  bool onHover = false;

  @override
  State<MyHoverCard> createState() => _MyHoverCardState();
}

class _MyHoverCardState extends State<MyHoverCard> {
  bool selected = false;
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AnimatedContainer(
          height: (isHover) ? 400 : 300,
          width: (isHover) ? 400 : 300,
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.only(
              top: (isHover) ? 25 : 30.0, bottom: !(isHover) ? 25 : 30),
          child: Container(
            height: 150,
            color: Colors.blue,
            child: InkWell(
              onTap: () {},
              child: Text(widget.title),
              onHover: (val) {
                print("Val--->{}$val");
                setState(() {
                  isHover = val;
                });
              },
            ),
            /*val--->true when user brings in mouse
           val---> false when brings out his mouse*/
          ),
        ),
      ),
    );
  }
}
