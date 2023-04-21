import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wordgen.dart';
import 'physics.dart';
import 'modules/lever1/lever1.dart';
import 'modules/acid-base/acidbase.dart';
import 'modules/lever2/lever2.dart';
import 'buildanatom.dart';

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
      ),
    );
  }
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
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: Constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Fav'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.gamepad),
                    label: Text('physics'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.gamepad),
                    label: Text('Lever1'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.gamepad),
                    label: Text('Lever2'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.gamepad),
                    label: Text('Acid or Base'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.gamepad),
                    label: Text('Building An Atom'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            )
          ],
        ),
      );
    });
  }
}

// const homeNavBtn = NavigationRailDestination(
//   icon: Icon(Icons.home),
//   label: Text('Home'),
// );

// const favNavBtn = NavigationRailDestination(
//   icon: Icon(Icons.favorite),
//   label: Text('Fav'),
// );

// const physicsNavBtn = NavigationRailDestination(
//   icon: Icon(Icons.gamepad),
//   label: Text('physics'),
// );

// const lever1NavBtn = NavigationRailDestination(
//   icon: Icon(Icons.gamepad),
//   label: Text('Lever1'),
// );

// const lever2NavBtn = NavigationRailDestination(
//   icon: Icon(Icons.gamepad),
//   label: Text('Lever2'),
// );

// const acidbaseNavBtn = NavigationRailDestination(
//   icon: Icon(Icons.gamepad),
//   label: Text('Acid or Base'),
// );

// const atomNavBtn = NavigationRailDestination(
//   icon: Icon(Icons.gamepad),
//   label: Text('Building An Atom'),
// );

// var navRail = NavigationRail(
//   extended: Constraints.maxWidth >= 600,
//   destinations: [
//     homeNavBtn,
//     favNavBtn,
//     physicsNavBtn,
//     lever1NavBtn,
//     lever2NavBtn,
//     acidbaseNavBtn,
//     atomNavBtn,
//   ],
//   selectedIndex: selectedIndex,
//   onDestinationSelected: (value) {
//     setState(() {
//       selectedIndex = value;
//     });
//   },
// );
