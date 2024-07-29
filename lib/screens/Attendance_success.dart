import 'package:cheminova/screens/home_screen.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:flutter/material.dart';

class AttendanceSuccess extends StatefulWidget {
  const AttendanceSuccess({super.key});

  @override
  State<AttendanceSuccess> createState() => _VerifySuccessFullScreenState();
}

class _VerifySuccessFullScreenState extends State<AttendanceSuccess> {
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
                  'Your Attendance\nHas been\nMarked!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Anek',
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add some space between the text and the image
              // Image.asset('assets/check_circle.png'),
            ],
          ),
        ),
      ),
    );
  }
}
