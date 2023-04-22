import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pocket_prayogshala/mycolors.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'wordgen.dart';
import 'physics.dart';
import 'modules/lever1/lever1.dart';
import 'modules/acid-base/acidbase.dart';
import 'modules/lever2/lever2.dart';
import 'buildanatom.dart';
import 'myHoverCard.dart';
import 'aboutUs.dart';
import 'ComingSoon.dart';
import 'modules/acid-base/AcidBasedetails.dart';
import 'modules/lever1/Lever1details.dart';
import 'modules/lever2/Lever2details.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

Widget box(String title, Color backgroundcolor) {
  return Container(
      margin: EdgeInsets.all(10),
      width: 280,
      color: backgroundcolor,
      alignment: Alignment.center,
      child: Text(title,
          style: TextStyle(
              color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)));
}

Widget horizontalScrollCreate(String title, var moduleList) {
  return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 40,
              color: Colors.amber[100],
              child: Center(
                  child: Text(title,
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)))),
          Container(
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: moduleList.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(30.0), //increased separation
                  child: MyHoverCard(
                    title: moduleList[index][0],
                    imagesrc: moduleList[index][1],
                    isImplemented: moduleList[index][2],
                    redirect: moduleList[index][3],
                  ),
                ),
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

// module[0] = name of module
// module[1] = image file location
// module[2] = 1 if implemented 0 otherwise
    var phyModules = [
      ["चाकल-चुकुल(see-saw)", 'seesaw.jpg', true, Lever1Page()],
      ["सरौतो(Nutcracker)", 'nutcracker.jpeg', true, Lever2Page()],
      [
        "गति र प्रवेग(Velocity and Acceleration)",
        'Velocity.jpg',
        false,
        SecondRoute()
      ],
      [
        "वायुमण्डलीय दबाव(Atmospheric Pressure)",
        'pressure.jpg',
        false,
        SecondRoute()
      ],
      [
        "प्रकाश को अपवर्तन(Refraction of Light)",
        'Refraction-of-Light.jpg',
        false,
        SecondRoute()
      ],
      ["गतिज ऊर्जा(Kinetic Energy)", 'kinetic.jpg', false, SecondRoute()]
    ];

    var chemModules = [
      ["अम्ल र क्षार(Acid and Base)", 'acid.jpg', true, AcidBasePage()],
      [
        "आंशिक आसवन(Fractional Distillation)",
        'distillation.jpg',
        false,
        SecondRoute()
      ],
      [
        "पर्मणुमा इलेक्ट्रोनको रचना(Electronic Configuration)",
        'atom.jpg',
        false,
        SecondRoute()
      ],
      [
        "रासायनिक प्रतिक्रिया(Chemical Reactions)",
        'chemical.jpg',
        false,
        SecondRoute()
      ],
      ["पानीको कठोरता(Hardness of Water)", 'water.png', false, SecondRoute()]
    ];

    //List<String> mathModules = [];

    var bioModules = [
      ["बीजको फैलावट(Dispersal of seed)", 'seed.jpeg', false, SecondRoute()],
      ["बीजको अंकुरण(Germination of seed)", 'seed1.jpeg', false, SecondRoute()],
      [
        "फूल फुल्ने बिरुवाको जीवन चक्र(Life Cycle of Flower)",
        'flower.jpg',
        false,
        SecondRoute()
      ],
      ["प्रकाश संश्लेषण(Photosynthesis)", 'photo.jpg', false, SecondRoute()]
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

    var myAppBar = AppBar(
      //ya bata paxadi loadig screen ma pheri najane
      automaticallyImplyLeading: false,
      backgroundColor: appBarBg,
      elevation: 8,
      shadowColor: appBarShadow,

      actions: <Widget>[
        Tooltip(
          message: 'About Us',
          child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUsPage()));
                },
                child: Icon(
                  Icons.info,
                  size: AppBar().preferredSize.height * 0.6,
                ),
              )),
        ),
      ],

      title: InkWell(
        onTap: () {
          //already on first page so do nothing
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
    );

    return Scaffold(
      appBar: myAppBar,
      body: verticalScroll, //,bodyColumn,
    );
  }
}
