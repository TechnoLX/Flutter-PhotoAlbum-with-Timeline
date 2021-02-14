import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:valentineAlb/model/sweetMemo_model.dart';
import 'package:valentineAlb/photoAlbum.dart';
import 'package:valentineAlb/valentine.dart';
import 'dart:convert';
import 'package:introduction_screen/introduction_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => MyHomePage()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Welcoming",
          body:
              "Welcome to this app, this is a simple app which to tell you a real story. Please click next button to start!",
          image: _buildImage('hello'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "A Sporty Guy",
          body:
              "There is a guy who like to do sport and passionate in learning new stuff in his life. He was staying single for about 28 years since he was born.",
          image: _buildImage('v1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "A Charming Girl",
          body:
              "And there is a girl who is really charming whe she smiles. She is so different, independent and caring person.",
          image: _buildImage('v2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Fall in Love",
          body:
              "The guy and the girl were first meet at a party, and all in love after that.",
          image: _buildImage('v3'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Love Journey",
          body:
              "They started dating, care about each other, food hunting and enjoying the moment for being together.",
          image: _buildImage('v4'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Valentine Day",
          body:
              "Today is Valentine's Day, the guy prepared a special little gift to the girl with his skill, and hope she will like it. Please click 'unbox' to view.",
          image: _buildImage('v5'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      skipFlex: 0,
      nextFlex: 0,
      next: const Icon(Icons.arrow_forward),
      done: const Text('unbox', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        activeColor: Colors.pinkAccent[100],
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SweetMemo _data;
  @override
  void initState() {
    super.initState();
    getText();
  }

  Future<void> getText() async {
    final text =
        await DefaultAssetBundle.of(context).loadString("json/sweetMemo.json");
    final res = json.decode(text);
    final data = SweetMemo.fromJson(res);
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.favorite_rounded),
          color: Colors.pink,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Valentine()));
          },
        ),
        title: Text('Sweet Memory'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TimelineTile(
            isFirst: index == 0 ? true : false,
            isLast: index == _data.timeline.length - 1 ? true : false,
            indicatorStyle: IndicatorStyle(
              width: 40,
              color: Colors.pink,
              iconStyle: IconStyle(
                  fontSize: 30.0,
                  iconData: IconData(57639, fontFamily: 'MaterialIcons')),
            ),
            alignment: TimelineAlign.manual,
            lineXY: 0.3,
            endChild: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Colors.pinkAccent[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    child: InkWell(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PhotoAlbum(_data.timeline[index]))),
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Text(
                              _data != null
                                  ? _data.timeline[index].title
                                  : 'no data',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            startChild: Container(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child:
                    Text(_data != null ? _data.timeline[index].date : 'no data',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        )),
              ),
            ),
          );
        },
        itemCount: _data != null ? _data.timeline.length : 0,
      ),
    );
  }
}
