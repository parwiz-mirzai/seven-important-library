import 'package:audioplayers/audioplayers.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:seven_library/recites.dart';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 233, 210),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 223, 212, 179),
        title: const Text('Seven library usage'),
      ),
      body: ListView(
        children: [
          MyListTile(context, ' AudioPlayer', AudioPlayerScreen()),
          MyListTile(context, ' Share App', const ShareApp()),
          MyListTile(context, ' Url_luncher', const Url_luncher()),
          MyListTile(context, ' botton navigation bar', const HomePage_1()),
          MyListTile(context, ' video plauer', const VideoPlayersList()),
          MyListTile(context, ' persiondatepicker', const Date_Page()),
          MyListTile(context, ' location', const MyApp()),
        ],
      ),
    );
  }
}

Widget MyListTile(BuildContext context, String title, Widget destinationPage) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destinationPage),
      );
    },
    child: ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back_ios),
          Text(
            title,
            style: const TextStyle(fontSize: 25),
          ),
        ],
      ),
    ),
  );
}

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void playAudio() {
    _audioPlayer.play(AssetSource('129199024.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Audio Player'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('When you click this botton an audio is played'),
              Container(
                color: const Color.fromARGB(255, 202, 187, 141),
                child: ElevatedButton(
                  onPressed: () {
                    playAudio();
                  },
                  child: const Icon(Icons.play_arrow),
                ),
              ),
            ],
          ),
        ));
  }
}

class ShareApp extends StatefulWidget {
  const ShareApp({super.key});

  @override
  State<ShareApp> createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            const String appLink =
                'https://play.google.com/store/apps/details?id=com.example.seven_library';
            Share.share(appLink);
          });
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.share),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      'when you click on this you will be able to share the app'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class Url_luncher extends StatefulWidget {
  const Url_luncher({super.key});

  @override
  State<Url_luncher> createState() => _Url_luncherState();
}

// ignore: camel_case_types
class _Url_luncherState extends State<Url_luncher> {
  void launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
      onPressed: () {
        launchURL('https://www.google.com/');
      },
      child: const Text('A link to google'),
    )));
  }
}

class HomePage_1 extends StatefulWidget {
  const HomePage_1({super.key});

  @override
  State<HomePage_1> createState() => _HomePageState_1();
}

int _index = 0;
List pages = [const Url_luncher(), AudioPlayerScreen(), const ShareApp()];

class _HomePageState_1 extends State<HomePage_1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: pages[_index],
          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            backgroundColor: const Color.fromARGB(232, 130, 162, 250),
            items: const <Widget>[
              Icon(Icons.link, size: 25),
              Icon(Icons.audio_file, size: 25),
              Icon(Icons.share, size: 25),
            ],
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

List Months = [
  "حمل",
  "ثور",
  "جوزا ",
  "سراطان",
  "اسد",
  "سنبله",
  "میزان",
  "عقرب",
  "قوس",
  "جدی",
  "دلو",
  "حوت",
];

class Date_Page extends StatefulWidget {
  const Date_Page({super.key});

  @override
  State<Date_Page> createState() => _Date_PageState();
}

class _Date_PageState extends State<Date_Page> {
  final DateTime gregorianDate = DateTime.now();

  var currentDate;
  var currentMonthe;
  var currentDay;
  var currentHoures;
  var currentMinut;
  var currentSecond;

  @override
  void initState() {
    currentDate = Jalali.now().year;
    currentMonthe = Jalali.now().month;
    currentDay = Jalali.now().day;

    currentHoures = new TimeOfDay.fromDateTime(gregorianDate).hourOfPeriod;
    currentMinut = TimeOfDay.fromDateTime(gregorianDate).minute;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text("Date and time"),
            ],
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("the current  year is : $currentDate"),
                Row(
                  children: [
                    Text(
                        "the current  month is : ${Months[currentMonthe - 1]}"),
                  ],
                ),
                Text("the current  day is : $currentDay"),
                const Divider(),
                Text("the current houre is : $currentHoures"),
                Text("the current  minute is : $currentMinut"),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _locationMessage = "";

  void getlocation() async {
    await Geolocator.checkPermission();

    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position);
    setState(() {
      _locationMessage = position.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("the location")],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("this is the location: $_locationMessage"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: getlocation, child: const Text("location")),
              )
            ],
          ),
        ),
      )),
    );
  }
}
