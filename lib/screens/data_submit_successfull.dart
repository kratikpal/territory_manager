import 'package:cheminova/screens/home_screen.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:flutter/material.dart';

class DataSubmitSuccessfull extends StatefulWidget {
  const DataSubmitSuccessfull({super.key});

  @override
  State<DataSubmitSuccessfull> createState() => DataSubmitSuccessfullState();
}

class DataSubmitSuccessfullState extends State<DataSubmitSuccessfull> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false, // Remove all routes
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CommonBackground(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
          const Text('Data Submitted\nsuccessfully',
              style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Anek')),
          const SizedBox(
              height: 20), // Add some space between the text and the image
          Image.asset(
            'assets/check_circle.png',
          )
        ]))));
  }
}
