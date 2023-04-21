import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'wordgen.dart';
import 'physics.dart';
import 'modules/lever1/lever1.dart';
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

Widget horizontalScrollCreate(String title, List<List<String>> moduleList) {
  return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              //height: 50,
              color: Colors.amber[100],
              child: Center(child: Text(title))),
          Container(
              height: 400,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: moduleList.length,
                itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: MyHoverCard(
                        title: moduleList[index][0],
                        imagesrc: moduleList[index][1])),
              ))
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
    // var bodyRow = Row(
    //   children: [
    //     mainArea,
    //   ],
    // );

    List<List<String>> phyModules = [
      ["चाकल-चुकुल(see-saw)", 'walnut1.png'],
      ["सरौतो(Nutcracker)", 'walnut2.png'],
      ["गति र प्रवेग(Velocity and Acceleration)", 'speed.jpg'],
      ["वायुमण्डलीय दबाव(Atmospheric Pressure)", 'walnut4.png'],
      ["प्रकाश को अपवर्तन(Refraction of Light)", 'supari_quarter.png'],
      ["गतिज ऊर्जा(Kinetic Energy)", 'supari.png']
    ];

    List<List<String>> chemModules = [
      ["अम्ल र क्षार(Acid and Base)", 'boy.png'],
      ["आंशिक आसवन(Fractional Distillation)", 'girl.png'],
      ["पर्मणुमा इलेक्ट्रोनको रचना(Electronic Configuration)", 'walnut1.png'],
      ["रासायनिक प्रतिक्रिया(Chemical Reactions)", 'walnut2.png'],
      ["पानीको कठोरता(Hardness of Water)", 'walnut3.png']
    ];

    //List<String> mathModules = [];

    List<List<String>> bioModules = [
      ["बीजको फैलावट(Dispersal of seed)", 'supari.png'],
      ["बीजको अंकुरण(Germination of seed)", 'supari_qaurter.png'],
      ["फूल फुल्ने बिरुवाको जीवन चक्र(Life Cycle of Flower)", 'boy.png'],
      ["प्रकाश संश्लेषण(Photosynthesis)", 'girl.png']
    ];

    var verticalScroll = ListView(
      padding: const EdgeInsets.all(8),
      children: [
        horizontalScrollCreate('भौतिकशास्त्र(Physics)', phyModules),
        horizontalScrollCreate('रसायन विज्ञान(Chemistry)', chemModules),
        horizontalScrollCreate('जीवविज्ञान(Biology)', bioModules),
        //horizontalScrollCreate('गणित(Maths)', mathModules),
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
  }
}
