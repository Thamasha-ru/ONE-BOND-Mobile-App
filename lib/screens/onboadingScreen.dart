import 'package:crypto_app/screens/loginRegister.dart';
import 'package:crypto_app/screens/signIn.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  final List<PageViewModel> pages = [
    PageViewModel(
      title: "Welcome To \n Onebond App",
      body: "This is a\ user friendly app.",
      image: Padding(
        padding: EdgeInsets.only(top: 20.0), // Adjust the top padding to create a gap
        child: Center(
          child: Image.asset("assets/images/welcome1.png", height: 400.0),
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color(0xFFF8F8F8)),
        bodyTextStyle: TextStyle(fontSize: 18.0),
      ),
    ),
    PageViewModel(
      title: "Fast And \n Flexible Trading",
      body: "Our app is easy to use and navigate.",
      image: Padding(
        padding: EdgeInsets.only(top: 20.0), // Adjust the top padding to create a gap
        child: Center(
          child: Image.asset("assets/images/welcome2.png", height: 400.0),
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color(0xFFF8F8F8)),
        bodyTextStyle: TextStyle(fontSize: 18.0),
      ),
    ),
    PageViewModel(
      title: "Fast And Reliable \n Market Updated",
      body: "Let's get started now!",
      image: Padding(
        padding: EdgeInsets.only(top: 20.0), // Adjust the top padding to create a gap
        child: Center(
          child: Image.asset("assets/images/welcome3.png", height: 400.0),
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color(0xFFF8F8F8)),
        bodyTextStyle: TextStyle(fontSize: 18.0),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0), // Creates a gap at the top
        child: Center(
          child: IntroductionScreen(
            pages: pages,
            onDone: () {
              // When done button is pressed
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => WelcomePage()),
              );
            },
            onSkip: () {
              // You can also override onSkip callback
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => WelcomePage()),
              );
            },
            showSkipButton: true,
            skip: const Text("Skip", style: TextStyle(color: Color(0xFFF5C249))),
            next: CircleAvatar(
              backgroundColor: Color(0xFFF5C249),
              child: const Icon(Icons.arrow_forward, color: Colors.black),
            ),
            done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFF5C249))),
            dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: Color(0xFFF5C249),
              color: Colors.black26,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
