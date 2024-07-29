import 'package:cheminova/screens/verify_code_screen.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../widgets/common_text_form_field.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  @override
  Widget build(BuildContext context) {

    return CommonBackground(
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
                      'assets/phone.png',
                      height: 50.0, // Adjust the height as needed
                      width: 50.0, // Adjust the width as needed
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Verify Phone Number',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Anek',
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        'Please enter your phone number\nto receive one time password',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Anek',
                        )),
                  ),
                  const SizedBox(height: 25),
                  CommonTextFormField(
                      title: ' Enter Your Mobile Number',
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 60),
                  Align(
                    alignment: Alignment.center,
                    child: CommonElevatedButton(
                      backgroundColor: const Color(0xff004791),
                      borderRadius: 30,
                      width: double.infinity,
                      height: kToolbarHeight - 10,
                      text: 'GET OTP',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const VerifyCodeScreen()));
                        // Handle OTP submission here
                        print('OTP submitted');
                      },
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
