import 'package:first_app_flutter/modules/lever1/lever1.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/rendering.dart';

class Lever2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var moduleThumbnail = InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Lever1()));
        },
        child: Expanded(
          flex: 1,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 234, 228, 228)),
            child: Image.asset(
              'assets/images/lever2_bg.jpg',
            ),
          ),
        ));
    var detailsArea = Expanded(
      flex: 1,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(color: Colors.yellow),
      ),
    );

    var instructionsText = Expanded(
        flex: 1,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 211, 220, 129)),
            child: Text(
              'ललितपुरमा शनिबार आयोजित नरबहादुर ललितपुरमा शनिबार आयोजित नरबहादुर  कर्मचार्य स्मृति प्रतिष्ठानको कार्यक्रम लाई सम्बोधन  गर्दै उनले पछिल्लो समय कम्युनिष्ट आन्दोलनमा मात्र नभई देशको समग्र राजनीतिमा र आर्थिक विकासको प्रक्रियामा नै विचार, सिद्धान्त, मूल्य, आदर्शमा विचलन देखिएको दाबी गरे । समाजमा देखिएका अराजकताका कारण खतरा पैदा हुने हो कि भन्ने डर पलाएको उनको भनाइ थियो । प्रधानमन्त्री दाहालले गत निर्वाचनमा विचार, सिद्धान्त, मूल्य, मान्यता र आदर्शलाई एजेन्डालाई भन्दा मान्छे सेन्टिमेन्टलाई प्रश्रय दिएकोप्रति दुःख व्यक्त गरे । उनले समाजमा यस किसिमका गतिविधि बढ्दै जाँदा बुद्धिजीवीहरुले हस्तक्षेपकारी भूमिका खेल्नुपर्ने बताए  ',
            )));

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            child: Image.asset('assets/images/logo.png'),
            onTap: () {
              Navigator.of(context).pop();
            }),
        title: Text('Pocket Prayogshala'),
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
