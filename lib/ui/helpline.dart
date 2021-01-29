import 'package:covd19/ui/colors.dart';
import 'package:flutter/material.dart';
import 'sceensize.dart';
import 'package:covd19/charts/wave_progress.dart';
import 'package:covd19/service/service_locator.dart';
import 'package:covd19/service/call_service.dart';

class Contact extends StatelessWidget {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Bgcolor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: 20,
          top: screenAwareSize(40, context),
        ),
        child: Column(
          children: <Widget>[
            Center(
                child: Text(
              " YARDIM HATLARI",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                inherit: true,
              ),
            )),
        
           
            vaweCard(
              context,
              "Coronavirus Danışma Hattı",
              "184",
              Colors.grey.shade100,
              Color(0xFF3CB371),
            ),
            vaweCard(
              context,
              "Polis İmdat Hattı",
              "155",
              Colors.grey.shade100,
              Color(0xFF3CB371),
            ),
            vaweCard(
              context,
              "Acil Çağrı Merkezi",
              "112",
              Colors.grey.shade100,
              Color(0xFF3CB371),
            ),
           vaweCard(
              context,
              "Jandarma İmdat Hattı",
              "156",
              Colors.grey.shade100,
              Color(0xFF3CB371),
            ),
          ],
        ),
      ),
    );
  }

  Widget vaweCard(BuildContext context, String name, String fields,
      Color fillColor, Color bgColor) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
        right: 20,
      ),
      padding: EdgeInsets.only(left: 15),
      height: screenAwareSize(80, context),
      decoration: BoxDecoration(
        color: Bgcolor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              WaveProgress(
                screenAwareSize(45, context),
                fillColor,
                bgColor,
                95,
              ),
              IconButton(
                icon: Icon(Icons.phone_in_talk),
                color: Colors.white,
                onPressed: () => _service.call(fields),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                    
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "$fields",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                 
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
