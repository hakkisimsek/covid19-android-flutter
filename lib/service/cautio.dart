import 'package:covd19/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class Cautions extends StatefulWidget {
  @override
  _CautionsState createState() => _CautionsState();
}

class _CautionsState extends State<Cautions> {

  SwiperController _swiperController;
  double prevOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _swiperController = SwiperController();
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> swiperItemsList = [
      buildSwiperItem(
          "assests/clean.png",
          "Özellikle halka açık bir yerdeyken ve  öksürdükten veya hapşırdıktan sonra ellerinizi sık sık sabun ve suyla en az 20 saniye yıkayın.",
          Color(0xFFfba457),
          firstGradient,
          "Ellerinizi sık sık temizleyin !"),
      buildSwiperItem(
          "assests/wash.png",
          "En az %60 alkol içeren bir el dezenfektanı kullanın. Ellerinizin tüm yüzeylerini kurulayınız.",
          Color(0xFFffcc00),
          secondtGradient,
          "Yakın Temastan Kaçının !"),
      buildSwiperItem(
          "assests/home.png",
          "Tıbbi bakım almak dışında hastaysanız evde kalın.",
          Color(0xFFd18cd6),
          thirdGradient,
          "Hastaysan evde kal !"),
      buildSwiperItem(
          "assests/mask.png",
          "Hastaysanız: Başkalarının yanındayken (örn. Bir odayı veya aracı paylaşırken) ve bir sağlık uzmanının ofisine girmeden önce bir yüz maskesi takmalısınız.",
          Color(0xFFd18cd6),
          thirdGradient,
          "Eğer hastaysan bir yüz maskesi tak !"),
      buildSwiperItem(
          "assests/sneeze.png",
          "Sık sık dokunulan yüzeyleri her gün temizleyin Ve dezenfekte edin. Buna masalar, kapı kolları,  tezgahlar, kulplar, masalar, telefonlar, klavyeler, tuvaletler, musluklar ve lavabolar dahildir.",
          Color(0xFFd18cd6),
          thirdGradient,
          "Temizleyin ve dezenfekte edin !"),
    ];
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Bgcolor,
      body: Container(
        color: Bgcolor,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Expanded(
              flex: 6,
              child: Swiper(
                controller: _swiperController,
                itemCount: swiperItemsList.length,
                onIndexChanged: (int value) {
                  if (value == 2) {
                    setState(() {
                      prevOpacity = 0.0;
                    });
                  } else {
                    setState(() {
                      prevOpacity = 1.0;
                    });
                  }
                },
                itemWidth: MediaQuery.of(context).size.width,
                itemHeight: MediaQuery.of(context).size.height / 1.5,
                itemBuilder: (BuildContext context, index) {
                  return swiperItemsList[index];
                },
                layout: SwiperLayout.TINDER,
                curve: Curves.bounceOut,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSwiperItem(String image, String text, Color color,
      Gradient gradient, String endText) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400.withOpacity(0.8),
            blurRadius: 4,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: gradient,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 8),
                        )
                      ]),
                ),
                Image.asset(
                  image,
                  fit: BoxFit.contain,
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                softWrap: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.3,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              endText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const firstGradient = LinearGradient(
  colors: [
    Color(0xFFfc792c),
    Color(0xFFfba457),
  ],
);

const secondtGradient = LinearGradient(
  colors: [
    Color(0xFFfeb700),
    Color(0xFFffcc00),
  ],
);

const thirdGradient = LinearGradient(
  colors: [
    Color(0xFFa978ad),
    Color(0xFFd18cd6),
  ],
);