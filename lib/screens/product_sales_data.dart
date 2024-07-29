import 'package:cheminova/screens/data_submit_successfull.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:intl/intl.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/common_elevated_button.dart';
import '../widgets/common_text_form_field.dart';

class ProductSalesData extends StatefulWidget {
  const ProductSalesData({super.key});

  @override
  State<ProductSalesData> createState() => ProductSalesDataState();
}

class ProductSalesDataState extends State<ProductSalesData> {
  final dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  final timeController =
  TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));

  final locationController = TextEditingController();
  final notesController = TextEditingController();
  final dealercontroller = TextEditingController();
  final productController = TextEditingController();
  final qualityController = TextEditingController();
  final salesController = TextEditingController();
  final commentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: Scaffold(backgroundColor: Colors.transparent,
        appBar: CommonAppBar(
          actions: [
            IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              icon: Image.asset('assets/Back_attendance.png'),    padding: const EdgeInsets.only(right: 20),
            ),
          ],
          title: const Text('Product Sales Data',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Anek')), backgroundColor: Colors.transparent, elevation: 0,
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
                          title: 'Select Dealer: Dealer 1',
                          fillColor: Colors.white,
                          controller: dealercontroller),
                      const SizedBox(height: 15),

                      CommonTextFormField(
                          title: 'Select Product: Product A',
                          fillColor: Colors.white,
                          controller: productController),
                      const SizedBox(height: 15),

                      CommonTextFormField(
                          title: 'Date Range: 10-06 to 20-06',
                          readOnly: true,
                          fillColor: Colors.white,
                          controller: dateController),
                      const SizedBox(height: 15),

                      Align(
                        alignment: Alignment.center,
                        child:    CommonElevatedButton(
                          borderRadius: 30,
                          width: double.infinity,
                          height: kToolbarHeight - 10,
                          text: 'VIEW DATA',
                          backgroundColor: const Color(0xff004791),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DataSubmitSuccessfull(),));
                          },

                          )

                        ),
                      ],
                  ),
                ),
              ],
            ),
          ),
        ),),
    );
  }
}