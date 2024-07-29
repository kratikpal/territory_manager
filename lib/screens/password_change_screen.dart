import 'package:cheminova/screens/home_screen.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:flutter/material.dart';

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({super.key});

  @override
  State<PasswordChangeScreen> createState() => PasswordChangeScreenState();
}

class PasswordChangeScreenState extends State<PasswordChangeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset('assets/Back_attendance.png')),
          backgroundColor: Colors.transparent),
      body: CommonBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF243B8A), // Background color of the message box
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Text(
                  'Password Changed\nsuccessfully',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Anek',
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add some space between the text and the image
              Image.asset('assets/check_circle.png'),
            ],
          ),
        ),
      ),
    );
  }
}
