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
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: AnimatedContainer(
          width: selected ? 200.0 : 100.0,
          height: selected ? 100.0 : 200.0,
          color: selected ? Colors.red : Colors.blue,
          alignment:
              selected ? Alignment.center : AlignmentDirectional.topCenter,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
          child: Text(widget.title),
        ),
      ),
    );
  }
}
