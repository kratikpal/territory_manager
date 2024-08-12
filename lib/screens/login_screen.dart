import 'package:cheminova/provider/login_provider.dart';
import 'package:cheminova/screens/forgot_password_screen.dart';
import 'package:cheminova/screens/home_screen.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:cheminova/widgets/common_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginProvider loginProvider;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loginProvider = LoginProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (_) => loginProvider,
      builder: (context, child) => Scaffold(
          body: CommonBackground(
        isFullWidth: false,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Welcome',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'Roboto')),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset('assets/cheminova_logo.png',
                        height: kToolbarHeight - 25),
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                  padding:
                      const EdgeInsets.all(20.0).copyWith(top: 15, bottom: 30),
                  margin: const EdgeInsets.symmetric(horizontal: 30.0)
                      .copyWith(bottom: 50),
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
                        const Text('Login',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto')),
                        const Text('Sign in to continue',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Roboto')),
                        const SizedBox(height: 20),
                        Consumer<LoginProvider>(
                          builder: (context, value, child) =>
                              CommonTextFormField(
                                  controller: value.emailController,
                                  keyboardType: TextInputType.emailAddress,
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
                                  title: 'Username'),
                        ),
                        const SizedBox(height: 20),
                        Consumer<LoginProvider>(
                            builder: (context, value, child) =>
                                CommonTextFormField(
                                    controller: value.passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                    title: 'Password')),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordScreen()));
                            },
                            child: const Text('Forgot Password?',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto')),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                            alignment: Alignment.center,
                            child: Consumer<LoginProvider>(
                              builder: (context, value, child) =>
                                  CommonElevatedButton(
                                backgroundColor: const Color(0xff004791),
                                borderRadius: 30,
                                width: double.infinity,
                                height: kToolbarHeight - 10,
                                text: 'SIGN IN',
                                isLoading: value.isLoading,
                                onPressed: () {
                                  loginProvider.login().then((result) {
                                    var (status, message) = result;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(message)));
                                    if (status) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage(),
                                        ),
                                      );
                                    }
                                  });
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
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
