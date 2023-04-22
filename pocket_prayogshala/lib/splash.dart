import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'ui.dart';
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
        title: 'पाँकेट  प्रयोगशाला',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)),
        home: MySplash(),
        scrollBehavior: MyCustomScrollBehavior(),
      ),
    );
  }
}

class MySplash extends StatelessWidget {
  var logoImage = Expanded(
    flex: 6,
    child: Center(
      child: Container(
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
        ),
      ),
    ),
  );

  Widget supportText = const Expanded(
    flex: 2,
    child: Text(
      //"नेपाल सरकार शिक्षा, विज्ञान तथा प्रविधि मन्त्रालयबाट सहयोग प्राप्त।  ",
      "usiky ljdkj f'k{kk] foKku rFkk çfof/k eU=ky;ckV lg;ksx çkIrA ",
      style: TextStyle(
        fontFamily: 'krutidevbold',
        fontSize: 40,
        color: Colors.black,
        //decoration: TextDecoration.underline,
        //decorationColor: Colors.red,
        //decorationStyle: TextDecorationStyle.solid,
      ),
    ),
  );

  Widget pressText = const Expanded(
    flex: 1,
    child: Text(
      //"agadi badhnako lagi click garnus ",
      "vxkMh tkudks ykfx LØhuek fDyd xuqZgksLA ",
      style: TextStyle(
        fontFamily: 'krutidev',
        fontSize: 30,
        color: Colors.black,
        //decoration: TextDecoration.underline,
        //decorationColor: Colors.red,
        //decorationStyle: TextDecorationStyle.solid,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      },
      child: Column(
        children: [
          logoImage,
          supportText,
          pressText,
        ],
      ),
    ));
  }
}
