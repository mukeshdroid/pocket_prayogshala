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
    var indivisualInfoAayam = Column(
      children: [
        Image.asset('assets/images/walnut1.png'),
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
        Image.asset('assets/images/walnut1.png'),
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
    var indivisualInfoMukesh = Column(
      children: [
        Image.asset('assets/images/walnut1.png'),
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
    );
    var personalRow = Row(
      children: [
        Expanded(flex: 1, child: indivisualInfoAayam),
        Expanded(flex: 1, child: indivisualInfoPriyanka),
        Expanded(flex: 1, child: indivisualInfoMukesh),
      ],
    );
    var generalInfo = RichText(
      text: TextSpan(
        text: 'Supervisor : Dr. Saraswati Acharya ',
        style: DefaultTextStyle.of(context).style,
        children: const <TextSpan>[
          TextSpan(text: '', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ' !'),
        ],
      ),
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
      body: Column(children: [
        personalRow,
        generalInfo,
      ]),
    );
  }
}
