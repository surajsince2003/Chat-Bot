import 'package:flutter/material.dart';
import 'package:chatbot/FirstScreen/FirstScreen.dart';
import 'package:chatbot/BottomnavBar/BottomnavBar.dart';
import 'package:chatbot/DatabaseHelper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late AnimationController _textController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  late Animation<Offset> _leftSlideAnimation;
  late Animation<Offset> _rightSlideAnimation;
  late Animation<double> _textFade;

  @override
  void initState() {
    super.initState();

    // Image expand animation
    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeIn,
    );

    // Text slide animation
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _leftSlideAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _rightSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _textFade = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    _imageController.forward();
    Future.delayed(const Duration(milliseconds: 700), () {
      _textController.forward();
    });

    Future.delayed(const Duration(seconds: 2), delayedCheckLoginStatus);
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void delayedCheckLoginStatus() async {
    final dbHelper = DatabaseHelper();
    final users = await dbHelper.getUsers();
    bool isLoggedIn = users.isNotEmpty;

    Get.off( isLoggedIn ? BottomNavBarScreen() : const FirstScreen(),);
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) =>
    //     isLoggedIn ? BottomNavBarScreen() : const FirstScreen(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          color: const Color.fromRGBO(188, 224, 240, 1),
          width: double.infinity,
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Hero(
                      tag: 'kaula',
                      child: Image.asset(
                        'assets/images/kaula.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 30),
                    FadeTransition(
                      opacity: _textFade,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SlideTransition(
                            position: _leftSlideAnimation,
                            child: Text(
                              'TRANQ',
                              style: GoogleFonts.juliusSansOne(
                                color: Colors.black,
                                fontSize: 34,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          SlideTransition(
                            position: _rightSlideAnimation,
                            child: Text(
                              'UILLO',
                              style: GoogleFonts.juliusSansOne(
                                color: Colors.black,
                                fontSize: 34,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
