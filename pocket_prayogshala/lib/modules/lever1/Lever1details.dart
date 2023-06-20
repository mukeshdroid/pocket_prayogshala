import 'package:pocket_prayogshala/modules/lever1/lever1.dart';
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

class Lever1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var moduleThumbnail = InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Lever1()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(color: Color.fromARGB(255, 234, 228, 228)),
          child: Image.asset(
            'assets/images/lever1thumbnail.png',
          ),
        ));

    var detailsArea = Expanded(
      flex: 1,
      child: Container(
        //width: MediaQuery.of(context).size.width * 0.5,
        // height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(color: Colors.yellow),
        child: Text('  १. सरल मेसिन (SImple Machine)  \n' +
            '    \n' +
            '  साधारण मेसिन भनेको एउटा यन्त्र हो जसले कामलाई सजिलो बनाउँछ, दिशा र/वा बलको परिमाण परिवर्तन गर्छ। हामीले  \n' +
            '  घरमा साधारण मेसिनहरू फेला पार्न सक्छाैँ ,जस्तै: ग्यारेजका ढोकाहरू, झण्डा पोलहरू, प्राइ बार,  कैंची, पेंच, चक्कु।  \n' +
            '    \n' +
            '  साधारण मेसिनले मानिसको प्रयासलाई कम गर्छ।  \n' +
            '  साधारण मेसिनले कामको गति बढाउँछ।  \n' +
            '  बल बढाउन सकिन्छ।  \n' +
            '  साधारण मेसिनले समय खपत कम गर्छ।  \n' +
            '  साधारण मेसिनले बलको दिशा परिवर्तन गर्न सक्छ।  \n' +
            '    \n' +
            '    \n' +
            '    \n' +
            '  उतोलक (Lever)  \n' +
            '    \n' +
            '  एक लीभर एक निश्चित काज, वा फुलक्रम मा पिभोटेड बीम वा कठोर रड समावेश गर्ने मेसिन हो। एक लीभर एक कठोर शरीर हो जुन आफैमा एक बिन्दुमा घुमाउन सक्षम छ।  \n' +
            '    \n'),
      ),
    );

    var instructionsText = Expanded(
        flex: 1,
        child: Container(
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 211, 220, 129)),
            child: Text('  १. सरल मेसिन (SImple Machine)  \n' +
                '    \n' +
                '  साधारण मेसिन भनेको एउटा यन्त्र हो जसले कामलाई सजिलो बनाउँछ, दिशा र/वा बलको परिमाण परिवर्तन गर्छ। हामीले  \n' +
                '  घरमा साधारण मेसिनहरू फेला पार्न सक्छाैँ ,जस्तै: ग्यारेजका ढोकाहरू, झण्डा पोलहरू, प्राइ बार,  कैंची, पेंच, चक्कु।  \n' +
                '    \n' +
                '  साधारण मेसिनले मानिसको प्रयासलाई कम गर्छ।  \n' +
                '  साधारण मेसिनले कामको गति बढाउँछ।  \n' +
                '  बल बढाउन सकिन्छ।  \n' +
                '  साधारण मेसिनले समय खपत कम गर्छ।  \n' +
                '  साधारण मेसिनले बलको दिशा परिवर्तन गर्न सक्छ।  \n' +
                '    \n' +
                '    \n' +
                '    \n' +
                '  उतोलक (Lever)  \n' +
                '    \n' +
                '  एक लीभर एक निश्चित काज, वा फुलक्रम मा पिभोटेड बीम वा कठोर रड समावेश गर्ने मेसिन हो। एक लीभर एक कठोर शरीर हो जुन आफैमा एक बिन्दुमा घुमाउन सक्षम छ।  \n' +
                '    \n')));

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
