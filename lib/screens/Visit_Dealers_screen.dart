import 'package:cheminova/widgets/common_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:intl/intl.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/common_elevated_button.dart';
import '../widgets/common_text_form_field.dart';
import 'package:image_picker/image_picker.dart';

class VisitDealersScreen extends StatefulWidget {
  const VisitDealersScreen({super.key});

  @override
  State<VisitDealersScreen> createState() => VisitDealersScreenState();
}

class VisitDealersScreenState extends State<VisitDealersScreen> {
  final dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  final timeController =
  TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));

  final notesController = TextEditingController();
  final dealerController = TextEditingController();
  final meetingSummaryController = TextEditingController();
  final followUpActionsController = TextEditingController();
  final nextVisitDateController = TextEditingController();

  String selectedPurpose = 'Sales/Liquidation';
  List<String> purposeOptions = ['Sales/Liquidation', 'Dues collection', 'Others'];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.camera);
    // Handle the picked image
  }

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
          title: const Text('Visit Retailers',
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
                  margin: const EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: const Color(0xffB4D1E5).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(26.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CommonTextFormField(
                          title: 'Select Retailer',
                          fillColor: Colors.white,
                          controller: dealerController),
                      const SizedBox(height: 15),
                      CommonTextFormField(
                          title: 'Visit date',
                          readOnly: true,
                          fillColor: Colors.white,
                          controller: dateController),
                      const SizedBox(height: 15),
                      CommonTextFormField(
                          title: 'Time',
                          readOnly: true,
                          fillColor: Colors.white,
                          controller: timeController),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Purpose of visit',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        value: selectedPurpose,
                        items: purposeOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPurpose = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      CommonTextFormField(
                          title: 'Meeting Summary:',
                          fillColor: Colors.white,
                          maxLines: 4,
                          controller: meetingSummaryController),
                      const SizedBox(height: 15),
                      CommonTextFormField(
                          title: 'Follow-up Actions:',
                          fillColor: Colors.white,
                          maxLines: 4,
                          controller: followUpActionsController),
                      const SizedBox(height: 15),
                      CommonTextFormField(
                          title: 'Next visit date:',
                          readOnly: true,
                          fillColor: Colors.white,
                          controller: nextVisitDateController),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextFormField(
                                title: 'Attach Documents/Photos',
                                fillColor: Colors.white,
                                controller: notesController),
                          ),
                          IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: _pickImage,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.center,
                        child: CommonElevatedButton(
                          borderRadius: 30,
                          width: double.infinity,
                          height: kToolbarHeight - 10,
                          text: 'SUBMIT',
                          backgroundColor: const Color(0xff004791),
                          onPressed: () {},
                        ),
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