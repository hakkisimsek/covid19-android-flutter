


import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:covd19/service/cautio.dart';
import 'package:covd19/ui/sceensize.dart';
import 'package:covd19/ui/helpline.dart';
import 'package:covd19/ui/colors.dart';

const String testDevice = 'Mobile_id';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  
  Animation virusBounce;
  Animation shadowFade;
  AnimationController animationController;
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


  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show(anchorType: AnchorType.top); 
    super.initState();
   
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              animationController.forward(from: 0.0);
            }
          });
    virusBounce = Tween(begin: Offset(0, 0), end: Offset(0, -20.0))
        .animate(animationController);
    shadowFade = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: Interval(0.4, 1.0), parent: animationController));

    animationController.forward();
   
  }



 @override
  void dispose() {
    _bannerAd.dispose();
    animationController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Bgcolor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 100, 25, 25),
          child: Center(
            child: Column(
              children: <Widget>[
                
                Transform.translate(
                  offset: virusBounce.value,
                  child: Image(
                    alignment: Alignment.centerRight,
                    image: AssetImage("assests/corona.png"),
                    height: screenAwareSize(200, context),
                    width: screenAwareSize(200, context),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Center(
                  child: Text(
                    'COVID-19',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                MaterialButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(40.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cautions()),
                    );
                  },
                  minWidth: double.infinity,
                  height: 40,
                  child: Text(
                    'Önlemler '.toUpperCase(),
                  ),
                  color: Fgcolor,
                  textColor: Colors.white,
                ),
                SizedBox(height: 5),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Contact()),
                    );
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  minWidth: double.infinity,
                  height: 40,
                  child: Text(
                    'Yardım Hattı'.toUpperCase(),
                  ),
                  color: Fgcolor,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
