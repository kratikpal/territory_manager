import 'package:flutter/material.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';

class ProductsManualScreen extends StatelessWidget {
  const ProductsManualScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonAppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset('assets/Back_attendance.png'),
              padding: const EdgeInsets.only(right: 20),
            ),
          ],
          title: const Text('Products Manual',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Anek')),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: const CommonDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20.0).copyWith(top: 30, bottom: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: const Color(0xffB4D1E5).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildProductButton('Product 1'),
                      _buildProductButton('Product 2'),
                      _buildProductButton('Product 3'),
                      _buildProductButton('Product 4'),
                      _buildProductButton('Product 5'),
                      _buildProductButton('Product 6'),
                      _buildProductButton('Product 7'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductButton(String productName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: CommonElevatedButton(
        borderRadius: 30,
        width: double.infinity,
        height: kToolbarHeight - 10,
        text: productName,
        backgroundColor: const Color(0xff004791),
        onPressed: () {
          // Handle product button press
          debugPrint('$productName pressed');
        },
      ),
    );
  }
}