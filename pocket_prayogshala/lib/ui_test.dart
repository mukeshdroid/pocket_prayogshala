import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'wordgen.dart';
import 'physics.dart';
import 'lever1.dart';
import 'modules/acid-base/acidbase.dart';
import 'modules/lever2/lever2.dart';
import 'buildanatom.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)),
        home: Scaffold(
            appBar: AppBar(title: const Text('my app')),
            body: MyHoverCard(
              title: 'Yessssssss',
            )),
        scrollBehavior: MyCustomScrollBehavior(),
      ),
    );
  }
}

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
