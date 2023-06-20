import 'package:pocket_prayogshala/modules/lever2/lever2.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/rendering.dart';
import '../../aboutUs.dart';
import '../../mycolors.dart';

class Lever2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var moduleThumbnail = InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Lever2()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(color: Color.fromARGB(255, 234, 228, 228)),
          child: Image.asset(
            'assets/images/lever2thumbnail.png',
          ),
        ));
    var detailsArea = Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(color: Colors.yellow),
        child: Text('  चाकल-चुकुल (See-saw)  \n' +
            '    \n' +
            '  पानीको केस उठाउन अलि गाह्रो हुन सक्छ, तर के तपाइँ अर्को व्यक्तिलाई उठाउन सक्नुहुन्छ ?? कुनै चीजको भार जति धेरै हुन्छ, त्यति नै कडा गुरुत्वाकर्षणले त्यसलाई तल तान्छ। तर मानिसहरूले लीभर जस्ता साधारण मेसिन प्रयोग गरेर गुरुत्वाकर्षण बललाई \'आउटस्मार्ट\' गर्न सिकेका छन्, जुन सीसमा मुख्य अवधारणा हो।  \n' +
            '    \n' +
            '  चाकल-चुकुल एक विशिष्ट प्रकारको उतोलक(लीभर) हो; यसमा फुलक्रम( ∆ ) भनिने धुरीमा(पिभोट) जोडिएको लामो बीम हुन्छ। किरणको एक छेउमा बसेर एक छेउमा तौल राख्ने बित्तिकै त्यो भुइँमा खस्छ। यो किनभने गुरुत्वाकर्षण बलले तपाईंको शरीरको वजनमा काम गरिरहेको छ, यसलाई तान्दै र किरण तल छ।  \n' +
            '    \n' +
            '  सिसको एक छेउमा तल धकेल्ने वा माथि धकेल्ने बलले अर्को छेउमा रहेको द्रव्यमानलाई प्रतिस्थापन गर्न सक्छ। लीभर जति लामो हुन्छ, भारी वस्तु उठाउनको लागि कम बल चाहिन्छ।  \n' +
            '              वजन* दूरी = वजन* दूरी  \n' +
            '    \n'),
      ),
    );

    var instructionsText = Expanded(
        flex: 1,
        child: Container(
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 211, 220, 129)),
            child: Text(
              '  प्रक्रिया:  \n' +
                  '  स्क्रिनमा एउटा चाकल-चुकुल, मानव र  विभिन्न  \n' +
                  '  तौलहरू छन्।हामी मानिसलाई चाकल-चुकुलको  कुनै पनि ठाउँमा राख्न सक्छौं र विभिन्न तौललाई अर्को छेउमा राखेर, हामीले मानिसको वजन पत्ता लगाउनु पर्छ।मानिसको तौल निर्धारण हुन्छ जब चाकल-चुकुल सीधा स्थितिमा आउँछ जुन तौलमा मात्र होइन तर फुलक्रमबाट दूरीमा पनि निर्भर हुन्छ।  \n' +
                  '    \n',
            )));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: appBarBg,
        elevation: 8,
        shadowColor: appBarShadow,
        title: InkWell(
          onTap: () {
            Navigator.pop(context);
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
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                moduleThumbnail,
                instructionsText,
              ],
            ),
            detailsArea,
          ],
        ),
      ),
    );
  }
}
