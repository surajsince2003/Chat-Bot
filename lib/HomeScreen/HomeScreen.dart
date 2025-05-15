import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 4.0,
          backgroundColor: const Color.fromRGBO(188, 224, 240, 1),
          centerTitle: true,
          title: Text(
            'Home Screen',
            style: GoogleFonts.figtree(fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: const Color.fromRGBO(188, 224, 240, 1),
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: mq.width * 0.86,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(18),
                        image: const DecorationImage(
                            fit: BoxFit.fitHeight,
                            // opacity: 0.8,
                            colorFilter: ColorFilter.mode(
                                Colors.black38, BlendMode.darken),
                            image: AssetImage('assets/images/conimg2.png'))),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Quote of the day',
                          style: GoogleFonts.kumbhSans(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '   It isn’t in my past.\n It’s in my everyday.',
                          style: GoogleFonts.kumbhSans(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: mq.width * 0.86,
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    padding: const EdgeInsets.only(left: 10, bottom: 20),
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(18),
                        image: const DecorationImage(
                            fit: BoxFit.fitHeight,
                            opacity: 1,
                            colorFilter: ColorFilter.mode(
                                Colors.black54, BlendMode.darken),
                            image: AssetImage('assets/images/conimg3.png'))),
                    child: Text(
                      'How to silence you inner critic\n after a trauma?',
                      style: GoogleFonts.kumbhSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 30),
                        width: double.infinity,
                        height: mq.height * 0.3,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 140),
                          margin: const EdgeInsets.only(right: 20),
                          // height: mq.height * 0.3,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About Tranquillo',
                                style: GoogleFonts.kumbhSans(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: mq.height * 0.138,
                                width: mq.width * 0.3,
                                child: Text(
                                    'Your personalized companion for PTSD recovery. With expertly curated resources, community support, and tailored coping mechanisms, Tranquillo empowers victims of PTSD to navigate their journey to healing with confidence and compassion.',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 7,
                                    style: GoogleFonts.kumbhSans(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0, // Adjust this position as needed
                        left: mq.width * 0.5,
                        right: 0,
                        child: SizedBox(
                          height:
                              mq.height * 0.34, // Adjust this height as needed
                          child: Image.asset(
                            'assets/images/kaula.png', // Your image URL
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
