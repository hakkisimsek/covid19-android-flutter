import 'package:covd19/ui/colors.dart';
import 'package:covd19/ui/LandingScreen.dart';
import 'package:covd19/ui/worldlist.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/services.dart';
import 'service/service_locator.dart';
import 'ui/globalStats.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
const String testDevice = 'Mobile_id';
void main() {
  setupLocator();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Bgcolor, fontFamily: 'Staatliches'),
      home: StartScreen()));
}

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}



class _StartScreenState extends State<StartScreen> {
  int _selectedIndex = 0;
  static int count = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Welcome(),
    Overview(),
    Worldlist(index: count),
   
  ];



static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    
    keywords: <String>['Game', 'Mario'],
  );

BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
      //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

 InterstitialAd _interstitialAd;

//Interstitial Ads
  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
      //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Bgcolor, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.white.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: GNav(
                gap: 3,
                activeColor: Colors.white,
                color: Colors.white,
                iconSize: 23,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.grey[800],
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Anasayfa',
                  ),
                  GButton(
                    icon: LineIcons.bar_chart,
                    text: 'İstatistikler',
                  ),
                  GButton(
                    icon: LineIcons.globe,
                    text: 'Dünya',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  print(count);
                  setState(() {
                    _widgetOptions = <Widget>[
                      Welcome(),
                      Overview(),
                      Worldlist(index: count),
                    
                    ];
                    _selectedIndex = index;
                    count = count + 1;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
