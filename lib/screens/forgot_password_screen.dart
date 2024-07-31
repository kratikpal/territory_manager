import 'package:cheminova/services/api_client.dart';
import 'package:cheminova/services/api_urls.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:cheminova/widgets/common_text_form_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool isLoading = false;

  void _submitEmail() {
    if (_formKey.currentState!.validate()) {
      // Process the form data
      _forgetPassword();
    }
  }

  Future<void> _forgetPassword() async {
    setState(() {
      isLoading = true;
    });

    try {
      final apiClient = ApiClient();
      Response response =
          await apiClient.post(ApiUrls.forgetPasswordUrl, data: {
        'email': _emailController.text.trim(),
      });

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.data['message'].toString()),
          ),
        );
        Navigator.pop(context);
      }
    } on DioException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.response?.data is Map<String, dynamic>) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.response?.data['message'].toString() ??
                'Something went wrong'),
          ),
        );
      } else if (e.response?.data is String) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(e.response?.data.toString() ?? 'Something went wrong'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
          ),
        );
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      isFullWidth: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/Back_attendance.png')),
          backgroundColor: Colors.transparent,
        ),
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        'assets/lock_logo2.png',
                        height: 50.0, // Adjust the height as needed
                        width: 50.0, // Adjust the width as needed
                      ),
                    ),
                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Anek',
                      ),
                    ),
                    const Text(
                      'Enter Registered Email ID to generate new password',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 20),
                    CommonTextFormField(
                      title: ' Enter Your Email ID',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email id';
                        }
                        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email id';
                        }
                        return null;
                      },
                      controller: _emailController,
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Back to Login',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.center,
                      child: CommonElevatedButton(
                        backgroundColor: const Color(0xff004791),
                        borderRadius: 30,
                        width: double.infinity,
                        isLoading: isLoading,
                        height: kToolbarHeight - 10,
                        text: 'SEND',
                        onPressed: _submitEmail,
                      ),
                    ),
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
