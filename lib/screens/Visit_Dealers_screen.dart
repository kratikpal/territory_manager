import 'package:cheminova/provider/visit_pdrd_provider.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/common_elevated_button.dart';
import '../widgets/common_text_form_field.dart';
import 'package:image_picker/image_picker.dart';

class VisitDealersScreen extends StatefulWidget {
  final String? tradeName;
  final String? id;
  const VisitDealersScreen({super.key, this.tradeName, this.id});

  @override
  State<VisitDealersScreen> createState() => VisitDealersScreenState();
}

class VisitDealersScreenState extends State<VisitDealersScreen> {
  late VisitPdRdProvider _visitPdRdProvider;
  final dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  final timeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));

  final notesController = TextEditingController();
  final dealerController = TextEditingController();
  final meetingSummaryController = TextEditingController();
  final followUpActionsController = TextEditingController();
  final nextVisitDateController = TextEditingController();
  late TextEditingController retailerController = TextEditingController();

  String selectedPurpose = 'Sales';
  List<String> purposeOptions = ['Sales', 'Dues collection', 'Others'];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.camera);
    // Handle the picked image
  }

  @override
  void initState() {
    _visitPdRdProvider = VisitPdRdProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    retailerController = TextEditingController(text: widget.tradeName);

    return ChangeNotifierProvider(
      create: (context) => _visitPdRdProvider,
      child: CommonBackground(
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
            title: Column(
              children: [
                const Text('Visit Retailers',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Anek')),
                Text(widget.tradeName ?? '',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Anek')),
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          drawer: const CommonDrawer(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.all(20.0).copyWith(top: 30, bottom: 30),
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: const Color(0xffB4D1E5).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(26.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CommonTextFormField(
                          readOnly: true,
                          title: 'Select Retailer',
                          fillColor: Colors.white,
                          controller: retailerController),
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
                      Consumer<VisitPdRdProvider>(
                        builder: (context, value, child) => Align(
                          alignment: Alignment.center,
                          child: CommonElevatedButton(
                            borderRadius: 30,
                            width: double.infinity,
                            height: kToolbarHeight - 10,
                            text: 'SUBMIT',
                            backgroundColor: const Color(0xff004791),
                            onPressed: () {
                              value.submitVisitPdRd(context, widget.id ?? '');
                            },
                          ),
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
