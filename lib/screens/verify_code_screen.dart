import 'dart:async';

import 'package:cheminova/screens/verify_successfull_screen.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  late Timer _timer;
  int _currentTime = 30;
  String _enteredOtp = "";

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _currentTime = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTime > 0) {
          _currentTime--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.transparent),
    ),
  );

  void _submitOtp() {
    if (_enteredOtp == "123456") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VerifySuccessFullScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Incorrect OTP"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  CommonBackground(
      isFullWidth: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.asset('assets/Back_attendance.png')),
            backgroundColor: Colors.transparent),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0).copyWith(top: 30, bottom: 30),
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: const Color(0xffB4D1E5).withOpacity(0.9),
                borderRadius: BorderRadius.circular(26.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/code_lock.png',
                      height: 50.0, // Adjust the height as needed
                      width: 50.0, // Adjust the width as needed
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Verification Code',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Anek',
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'OTP has sent to your registered \nmobile number, Please verify',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Anek',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Pinput(
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onChanged: (pin) {
                      _enteredOtp = pin;
                    },
                    onCompleted: (pin) => print(pin),
                  ),
                  const SizedBox(height: 20),
                  Align(
                     alignment: Alignment.center,
                    child: Text(
                      'Resend OTP : $_currentTime',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Anek',
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.center,
                    child: CommonElevatedButton(
                      backgroundColor: const Color(0xff004791),
                      borderRadius: 30,
                      width: double.infinity,
                      height: kToolbarHeight - 10,
                      text: 'Verify',
                      onPressed: _submitOtp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
