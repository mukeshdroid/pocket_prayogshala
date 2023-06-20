import 'package:pocket_prayogshala/modules/acid-base/acidbase.dart';
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

class AcidBasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var moduleThumbnail = InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => acidBase()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(color: Color.fromARGB(255, 234, 228, 228)),
          child: Image.asset(
            'assets/images/acidbasethumbnail.png',
          ),
        ));
    var detailsArea = Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(color: Colors.yellow),
        child: Text('    \n' +
            '  अम्ल र क्षार(Acid-Base)  \n' +
            '  अम्ल(Acid):  \n' +
            '    \n' +
            '  एसिड कुनै पनि हाइड्रोजन युक्त पदार्थ हो जुन अर्को पदार्थमा प्रोटोन (हाइड्रोजन आयन) दान गर्न सक्षम हुन्छ। अम्लीय पदार्थहरू सामान्यतया तिनीहरूको खट्टा स्वाद द्वारा पहिचान गरिन्छ।  \n' +
            '    \n' +
            '    \n' +
            '  क्षार(Base):  \n' +
            '    \n' +
            '  क्षार भनेको एसिडबाट हाइड्रोजन आयन स्वीकार गर्न सक्षम अणु वा आयन हो।  \n' +
            '    \n' +
            '  सामान्य गुणहरू:  \n' +
            '    \n' +
            '  एसिडले अमिलो स्वाद दिन्छ, जस्तै, सिट्रस फलफूलको स्वादको स्रोत सिट्रस एसिड र एस्कर्बिक एसिड, अर्थात्, भिटामिन सी, तिनीहरूमा हुन्छ। आधारभूत (क्षारीय) पदार्थ, अर्कोतर्फ, तीतो स्वाद।  \n' +
            '  आधारभूत (क्षारीय) पदार्थहरू सूपी महसुस गर्छन्, जबकि अम्लीय पदार्थहरूले डंक गर्न सक्छन्।  \n' +
            '  एसिडले नीलो लिटमस पेपरलाई पढ्नको लागि बदल्छ तर रातो लिटमस पेपरको रंग परिवर्तन गर्दैन। आधारहरू रातो लिटमस पेपर नीलो बन्छन् तर नीलो लिटमस पेपरको रङ परिवर्तन गर्दैनन्।  \n' +
            '  फेनोल्फ्थलेइन् सूचक एसिडमा रंगहीन र आधारभूत घोलमा गुलाबी हुन्छ ।  \n' +
            '  एसिड र बेसहरूले एकअर्कालाई बेअसर गर्छन्। पेटमा हाइड्रोक्लोरिक एसिड पाइन्छ जसले पाचनमा मद्दत गर्छ। अतिरिक्त हाइड्रोक्लोरिक एसिडले एसिड जलाउन सक्छ ।  \n' +
            '    \n' +
            '    \n'),
      ),
    );

    var instructionsText = Expanded(
        flex: 1,
        child: Container(
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 211, 220, 129)),
            child: Text('  "एसिड-आधार रंग-परिवर्तन प्रतिक्रिया\  \n' +
                '   सामग्री:\  \n' +
                '  १.पिपेट\  \n' +
                '  २.बीकरहरू\  \n' +
                '  ३.संकेतकहरू: फेनोल्फथालियन र मिथाइल ओरेन्ज\  \n' +
                '  प्रक्रिया:\  \n' +
                '  स्क्रिनमा तीनवटा बीकरहरू छन्। बीचमा रहेको बीकरमा अज्ञात तरल पदार्थ हुन्छ।अन्य दुई बीकरहरूमा सूचकहरू छन्: फेनोल्फथालियन र मिथाइल ओरेन्ज। लक्ष्य ती सूचकहरूको मद्दतले तरल पदार्थ एसिड वा क्षार हो कि भनेर पहिचान गर्नु हो।\  \n' +
                '  १. पहिले, पिपेटमा कुनै एक सूचक लिनुहोस् र यसलाई अज्ञात तरलमा राख्नुहोस्।\  \n' +
                '  २.तरल पदार्थको रङमा भएको परिवर्तनलाई अवलोकन गर्नुहोस् र यो एसिड वा आधार हो कि भनेर निर्धारण गर्नुहोस्।\  \n' +
                '  फेनोल्फ्थलेइन् र मिथाइल ओरेन्ज सूचक हो - एक रसायन जसले रंग परिवर्तन गर्दछ कि यो अम्ल वा आधार मा निर्भर गर्दछ। यदि यसले अमोनिया जस्ता क्षार भेट्छ भने फेनोल्फ्थलेइन् गुलाबी हुन्छ; यो रङ्गहीन रहन्छ यदि यो सिरका जस्तै अम्ल वा पानी जस्तै तटस्थ पदार्थ मिल्छ।अम्लीय माध्यममा, मिथाइल ओरेन्जले रातो रंग दिन्छ र आधारभूत माध्यममा, यसले पहेंलो रंग दिन्छ। "  \n')));

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
