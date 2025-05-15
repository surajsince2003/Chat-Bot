import 'package:chatbot/BottomnavBar/BottomnavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  var name;

  WelcomeScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: mq.width * 1,
      height: double.infinity,
      padding: EdgeInsets.only(top: 70),
      alignment: Alignment.bottomCenter,
      color: Color.fromRGBO(188, 224, 240, 1),
      child: Stack(children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            // color: Colors.red,
            height: 230,
            width: mq.width,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/kaula.png',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 40),
            height: mq.height * 0.6,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            margin: EdgeInsets.only(top: 280),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Hello, ' + name,
                  style: GoogleFonts.kumbhSans(fontSize: 24),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'How are you feeling today?',
                  style: GoogleFonts.kumbhSans(fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(color: Color.fromRGBO(31, 69, 86, 0.6)),
                SizedBox(
                  height: 40,
                ),
                Image.asset('assets/images/emoji.png'),
                Spacer(),
                SizedBox(
                  width: mq.width * 1,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(31, 69, 86, 1),
                      ),
                      onPressed: () {
                        Get.off(BottomNavBarScreen());

                      },
                      child: Text(
                        'Explore Tranquillo',
                        style: GoogleFonts.kumbhSans(
                            fontSize: 14, color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
