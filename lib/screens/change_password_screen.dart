import 'package:cheminova/provider/login_provider.dart';
import 'package:cheminova/screens/password_change_screen.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:cheminova/widgets/common_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/common_drawer.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  CommonBackground(
        isFullWidth: true,
      child: Scaffold(
        drawer: const CommonDrawer(),

          backgroundColor: Colors.transparent,

          appBar: CommonAppBar(

          title: const Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset('assets/Back_attendance.png'),
              padding: const EdgeInsets.only(right: 20),
            ),
          ],
        ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // const SizedBox(height: 50),
                  // const SizedBox(height: 60),
                  Container(
                    padding:
                        const EdgeInsets.all(20.0).copyWith(top: 15, bottom: 30),
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: const Color(0xffB4D1E5).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(26.0)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          const Text('Change Password',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto')),
                          const SizedBox(height: 20),
                          CommonTextFormField(
                            //  controller: value.emailController,
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
                              title: 'Current Password'),
                          const SizedBox(height: 20),
                          CommonTextFormField(
                          //    controller: value.passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              title: 'New Password'),  const SizedBox(height: 20),
                          CommonTextFormField(
                          //    controller: value.passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              title: 'Confirm Password'),
                          const SizedBox(height: 15),
                          Align(
                              alignment: Alignment.center,
                              child: CommonElevatedButton(
                                                              backgroundColor: const Color(0xff004791),
                                                              borderRadius: 30,
                                                              width: double.infinity,
                                                              height: kToolbarHeight - 10,
                                                              text: 'SIGN IN',
                                                              isLoading: false,
                                                              onPressed: () {
                                                               Navigator.push(context, MaterialPageRoute(builder:(context) => const PasswordChangeScreen()));
                                                              },
                                                              // onPressed: value.isLoading
                                                              //     ? null
                                                              //     : () async {
                                                              //         if (_formKey.currentState!.validate()) {
                                                              //           value.login().then((result) {
                                                              //             var (status, message) = result;
                                                              //             ScaffoldMessenger.of(context)
                                                              //                 .showSnackBar(SnackBar(
                                                              //                     content: Text(message)));
                                                              //             if (status) {
                                                              //               Navigator.pushReplacement(
                                                              //                   context,
                                                              //                   MaterialPageRoute(
                                                              //                       builder: (context) =>
                                                              //                           const HomePage()));
                                                              //             }
                                                              //           });
                                                              //         }
                                                              //       },
                                                            ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
    );
  }
}
