import 'package:cheminova/screens/data_submit_successfull.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:intl/intl.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/common_elevated_button.dart';
import '../widgets/common_text_form_field.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => SummaryScreenState();
}

class SummaryScreenState extends State<SummaryScreen> {
  final dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  final timeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));

  final ProductController = TextEditingController();
  final liquidationController = TextEditingController();
  final dealercontroller = TextEditingController();
  final inventoryController = TextEditingController();
  final qualityController = TextEditingController();
  final salesController = TextEditingController();
  final skuController = TextEditingController();

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
          title: const Text('Summary',
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
                  padding:
                      const EdgeInsets.all(20.0).copyWith(top: 30, bottom: 30),
                  // margin: const EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: const Color(0xffB4D1E5).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(26.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CommonTextFormField(
                          title: 'Sales :',
                          fillColor: Colors.white,
                          controller: salesController),
                      const SizedBox(height: 15),
                      CommonTextFormField(
                          title: 'Inventory :',
                          fillColor: Colors.white,
                          controller: inventoryController),
                      const SizedBox(height: 15),
                      CommonTextFormField(
                          title: 'Liquidation :',
                          fillColor: Colors.white,
                          controller: liquidationController),
                      const SizedBox(height: 15),
                      CommonTextFormField(
                          title: 'SKU :',
                          fillColor: Colors.white,
                          controller: skuController),
                      const SizedBox(height: 15),
                      CommonTextFormField(
                          title: 'Product :',
                          fillColor: Colors.white,
                          controller: ProductController),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.center,
                        child: CommonElevatedButton(
                          borderRadius: 30,
                          width: double.infinity,
                          height: kToolbarHeight - 10,
                          text: 'VIEW DATA',
                          backgroundColor: const Color(0xff004791),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DataSubmitSuccessfull()));

                          })
                        ),

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
}
