import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:pocket_prayogshala/my_icons_icons.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

Widget urlText(String link, String description, String substitute, bool showUrl,
    Icon icon) {
  String displayText = '';
  if (showUrl) {
    displayText = ' ${description} : ${link}';
  } else {
    displayText = ' ${description} : ${substitute}';
  }

  return InkWell(
    onTap: () {
      launchInBrowser(Uri.parse(link));
    },
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        icon,
        Text(displayText),
      ],
    ),
  );
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double unitWidthValue = MediaQuery.of(context).size.width * 0.01;

    double radMul = 15;

    var indivisualInfoAayam = Column(
      children: [
        ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius((unitHeightValue < unitWidthValue)
                ? unitHeightValue * radMul
                : unitWidthValue * radMul), // Image radius
            child: Image.asset(
              'assets/images/aayam.jpg',
            ),
          ),
        ),
        Text('Aayam Basyal'),
        urlText(
          'https://github.com/ayambasyal',
          'Github',
          '@ayambasyal',
          false,
          Icon(MyIcons.github_circled),
        ),
        urlText(
          'https://www.linkedin.com/in/ayam-basyal/',
          'LinkedIn',
          'Ayam Basyal',
          false,
          const Icon(MyIcons.linkedin_circled),
        ),
      ],
    );
    var indivisualInfoPriyanka = Column(
      children: [
        ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius((unitHeightValue < unitWidthValue)
                ? unitHeightValue * radMul
                : unitWidthValue * radMul), // Image radius
            child: Image.asset(
              'assets/images/priyanka.jpg',
            ),
          ),
        ),
        Text('Priyanka Panta'),
        urlText(
          'https://github.com/priyanka00200',
          'Github',
          '@priyanka00200',
          false,
          Icon(MyIcons.github_circled),
        ),
        urlText(
          'https://np.linkedin.com/in/priyanka-panta-8451b4251?trk=public_profile_browsemap',
          'LinkedIn',
          'Priyanka Panta',
          false,
          const Icon(MyIcons.linkedin_circled),
        ),
      ],
    );
    var indivisualInfoMukesh = Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              size: Size.fromRadius((unitHeightValue < unitWidthValue)
                  ? unitHeightValue * radMul
                  : unitWidthValue * radMul), // Image radius
              child: Image.asset(
                'assets/images/mukesh.jpeg',
              ),
            ),
          ),
          Text('Mukesh Tiwari'),
          urlText(
            'https://github.com/mukeshdroid',
            'Github',
            '@mukeshdroid',
            false,
            Icon(MyIcons.github_circled),
          ),
          urlText(
            'https://np.linkedin.com/in/mukesh-tiwari1?trk=public_profile_browsemap',
            'LinkedIn',
            'Mukesh Tiwari',
            false,
            const Icon(MyIcons.linkedin_circled),
          ),
        ],
      ),
    );

    var personalRow = Row(
      children: [
        Expanded(flex: 1, child: indivisualInfoAayam),
        Expanded(flex: 1, child: indivisualInfoPriyanka),
        Expanded(flex: 1, child: indivisualInfoMukesh),
      ],
    );

    var info_us = RichText(
      text: TextSpan(
        text:
            'We are a group of students studying computational mathematics at Kathmandu University, located in Nepal.'
            ' As students of this field, we have a deep understanding of mathematical principles, computer science, and algorithms, and we have applied this knowledge to create an innovative app. '
            'This app is specifically designed for the class 8 curriculum intended'
            ' to make learning more engaging and interactive for students in this grade, and it can help them better understand and retain the material.',
        style: TextStyle(color: Colors.black, fontSize: 20),
        children: const <TextSpan>[
          TextSpan(
              text: '',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          TextSpan(text: ' '),
        ],
      ),
      textAlign: TextAlign.center,
    );

    var generalInfo = RichText(
      text: TextSpan(
        text: '  ',
        style: TextStyle(color: Colors.black, fontSize: 20),
        children: const <TextSpan>[
          TextSpan(
              text: 'Supervisor : Dr. Saraswati Acharya',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          TextSpan(text: ' '),
        ],
      ),
      textAlign: TextAlign.center,
    );
    return Scaffold(
      appBar: AppBar(
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
      body: Column(
        children: [
          personalRow,
          info_us,
          generalInfo,
        ],
      ),
    );
  }
}
