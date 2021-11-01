import 'package:flutter/material.dart';
import 'package:hungrybuff/user/authentication/ui/login_screen.dart';
import 'package:hungrybuff/utils/textStyles.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Widget> list = new List();
  int currentIndex = 0;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    getSharePreferenceInstance();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Food Stall",
          body:
              "We prepare and deliver the food at your doorstep you just have to open your door and take the delicious food.",
          image: Center(
            child: Image.asset(
              "assets/welcome/walk_img_1.png",
            ),
          ),
        ),
        PageViewModel(
          title: "Self Pickup",
          body:
              "We prepare and deliver the food at your doorstep you just have to open your door and take the delicious food.",
          image: Center(
            child: Image.asset(
              "assets/welcome/walk_img_2.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
        PageViewModel(
          title: "Easy Payment",
          body:
              "We prepare and deliver the food at your doorstep you just have to open your door and take the delicious food.",
          image: Center(
            child: Image.asset(
              "assets/welcome/walk_img_3.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
      onDone: () {
        onLetsGetStartButtonPressed();
      },
      onSkip: onSkipButtonPressed,
      next: const Icon(Icons.arrow_forward),
      done: const Text('Get Started',
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(245, 116, 14, 1))),
      showSkipButton: true,
      skip: getSkipButton(),
    );
  }

  Widget getSkipButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          onPressed: () => onSkipButtonPressed(),
          child: Text(
            "SKIP",
            style: orangeSkip,
          ),
        )
      ],
    );
  }

  onLetsGetStartButtonPressed() {
    prefs.setBool("CanGoToIntro", false);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  onSkipButtonPressed() {
    prefs.setBool("CanGoToIntro", false);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  Future<void> getSharePreferenceInstance() async {
    prefs = await SharedPreferences.getInstance();
  }
}
