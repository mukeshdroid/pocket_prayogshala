import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'wordgen.dart';
import 'physics.dart';
import 'lever1.dart';
import 'modules/acid-base/acidbase.dart';
import 'modules/lever2/lever2.dart';
import 'buildanatom.dart';
import 'myHoverCard.dart';

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
        home: MyHomePage(),
        scrollBehavior: MyCustomScrollBehavior(),
      ),
    );
  }
}

Widget box(String title, Color backgroundcolor) {
  return Container(
      margin: EdgeInsets.all(10),
      width: 280,
      color: backgroundcolor,
      alignment: Alignment.center,
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20)));
}

Widget horizontalScrollCreate(String title, var moduleList) {
  return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
              height: 50,
              color: Colors.amber[100],
              child: Center(child: Text(title))),
          Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: moduleList.map<Widget>((module) {
                  return MyHoverCard(title: module);
                }).toList(),
              )),
        ],
      ));
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavPage();
        break;
      case 2:
        page = PhyPage();
        break;
      case 3:
        page = Lever1();
        break;
      case 4:
        page = Lever2();
        break;
      case 5:
        page = acidBasePage();
        break;
      case 6:
        page = BuildAtom();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, Constraints) {
      var mainArea = Container(
        height: 500,
        color: Theme.of(context).colorScheme.primaryContainer,
        child: page,
      );

      var bodyRow = Row(
        children: [
          mainArea,
        ],
      );

      List<String> phyModules = [
        "sdasdas",
        "asdasd",
        "Iasd",
        "adasd",
        "gfhfg",
        "cvxcv"
      ];

      List<String> chemModules = [
        "sdasdas",
        "asdasd",
        "Iasd",
        "adasd",
        "gfhfg",
        "cvxcv"
      ];

      List<String> mathModules = [
        "sdasdas",
        "asdasd",
        "Iasd",
        "adasd",
        "gfhfg",
        "cvxcv"
      ];

      List<String> bioModules = [
        "sdasdas",
        "asdasd",
        "Iasd",
        "adasd",
        "gfhfg",
        "cvxcv"
      ];

      var verticalScroll = ListView(
        padding: const EdgeInsets.all(8),
        children: [
          horizontalScrollCreate('Physcis', phyModules),
          horizontalScrollCreate('Chemistry', chemModules),
          horizontalScrollCreate('Biology', bioModules),
          horizontalScrollCreate('Maths', mathModules),
        ],
      );

      var titleText = Container(
          height: 50,
          child: const Text(
            'Hello',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ));

      var titleBar = Container(
          color: Colors.cyan,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              titleText,
            ],
          ));

      var bodyColumn = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleBar,
          //mainArea,
          //bodyRow,
          //horizontalScroll,
          verticalScroll,
        ],
      );

      return Scaffold(body: verticalScroll //bodyColumn,
          );
    });
  }
}
