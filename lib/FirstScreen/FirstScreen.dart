import 'package:chatbot/LoginScreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(188, 224, 240, 1),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'kaula',
              child: Image.asset(
                'assets/images/kaula.png',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'TRANQUILLO',
              style:
                  GoogleFonts.juliusSansOne(color: Colors.black, fontSize: 34),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(31, 69, 86, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70)),
                    padding: const EdgeInsets.all(10)),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                },
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 54,
                ))
          ],
        ),
      ),
    );
  }
}
