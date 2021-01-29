import 'dart:convert';
import 'package:covd19/ui/colors.dart';
import 'package:covd19/ui/sceensize.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:http/http.dart' as http;
import 'package:covd19/service/Apimode.dart';
import 'package:covd19/ui/countrydetail.dart';
import 'package:line_icons/line_icons.dart';
const String testDevice = 'Mobile_id';
 class Worldlist extends StatefulWidget {

final int index;

  // In the constructor, require a Todo.
  Worldlist({Key key, @required this.index}) : super(key: key);


   @override
   _WorldlistState createState() => _WorldlistState();
 }
 
 class _WorldlistState extends State<Worldlist> {
  List<Corona> test, sample, _dat1;
  int count =0;

  var jsondata;
  Details d, temp, a;
  String s = "http://www.oxitbilisim.com/covid-dunya-yayin.json";
  Future<void> getData() async {
    final response = await http.get(s);
    jsondata = json.decode(response.body);
    d = Details.fromJson(jsondata);
    test = d.corona;
    setState(() {
      sample = test;
      _dat1 = sample;
    });
  }

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
  void initState() {
    print(widget.index);
    getData();
     FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
      FirebaseAdMob.instance.initialize(appId: InterstitialAd.testAdUnitId);
     var x= _interstitialAd = createInterstitialAd()
      ..load();
    //Change appId With Admob Id
    if (widget.index%2 ==0){
     x..show(anchorType: AnchorType.top); 

    }
    else{
      x.dispose();
    }

    
   
      _bannerAd = createBannerAd()
      ..load()
      ..show(anchorType: AnchorType.top); 
    super.initState();
    
  }
@override
  void dispose() {
    _interstitialAd.dispose();
    _bannerAd.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      //backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
      //backgroundColor:Color(0xFFFF3B4254),
      backgroundColor: Bgcolor,
      body: d == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(Fgcolor),
              ),
            )
          : RefreshIndicator(
              onRefresh: getData,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Container(
                    width: screenAwareSize(300, context),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: screenAwareSize(40, context),
                    decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0))),
                    child: TextField(
                      style: new TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 8.0),
                        border: InputBorder.none,
                        hintText: 'Ülke Ara...',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 12.0),
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                      ),
                      onChanged: (text) {
                        setState(() {
                          _dat1 = sample
                              .where((r) => (r.country
                                  .toLowerCase()
                                  .contains(text.trim().toLowerCase())))
                              .toList();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: _dat1
                          .map((pointer) => Padding(
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  padding: EdgeInsets.only(left: 7),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Coronad(
                                                    corona: pointer,
                                                  )));
                                    },
                                    child: Card(
                                      color: Bgcolor,
                                      margin: new EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assests/coronadetails.png"),
                                        ),
                                        title: Text(
                                          pointer.country,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "Toplam Vaka : " +
                                              pointer.totalCases.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            LineIcons.arrow_circle_o_right,
                                            color: Colors.white,
                                          ),
                                          iconSize: 31,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Coronad(
                                                          corona: pointer,
                                                        )));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
