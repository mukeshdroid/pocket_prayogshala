import 'package:flutter/material.dart';
import 'SecondRoute.dart';

class MyHoverCard extends StatefulWidget {
  MyHoverCard({super.key, this.title = "default", required this.imagesrc});

  String title = 'hello';
  bool selected = false;
  bool onHover = false;
  String imagesrc = '';

  @override
  State<MyHoverCard> createState() => _MyHoverCardState();
}

class _MyHoverCardState extends State<MyHoverCard> {
  bool selected = false;
  bool isHover = false;

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
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
                    MaterialPageRoute(builder: (context) => SecondRoute()));
              },
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/${widget.imagesrc}',
                  ),
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
            /*val--->true when user brings in mouse
           val---> false when brings out his mouse*/
          ),
        ),
      ),
    );
  }
}
