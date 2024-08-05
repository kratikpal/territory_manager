import 'package:cheminova/models/get_pd_response.dart';
import 'package:cheminova/provider/collect_kyc_provider.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/common_elevated_button.dart';
import '../widgets/common_text_form_field.dart';

class RetailerDetailsScreen extends StatefulWidget {
  const RetailerDetailsScreen({super.key});

  @override
  State<RetailerDetailsScreen> createState() => RetailerDetailsScreenState();
}

class RetailerDetailsScreenState extends State<RetailerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CollectKycProvider>(
        builder: (BuildContext context, CollectKycProvider value,
                Widget? child) =>
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(20.0)
                          .copyWith(top: 30, bottom: 30),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: const Color(0xffB4D1E5).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(26.0)),
                      child: Form(
                        key: value.retailerDetailsFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonTextFormField(
                                title: 'Trade Name',
                                fillColor: Colors.white,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Trade Name cannot be empty';
                                  }
                                  return null;
                                },
                                controller: value.tradeNameController),
                            const SizedBox(height: 15),
                            CommonTextFormField(
                                title: 'Name',
                                fillColor: Colors.white,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Name cannot be empty';
                                  }
                                  return null;
                                },
                                controller: value.nameController),
                            const SizedBox(height: 15),
                            CommonTextFormField(
                                title: 'Address',
                                fillColor: Colors.white,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Address cannot be empty';
                                  }
                                  return null;
                                },
                                controller: value.addressController),
                            const SizedBox(height: 15),
                            CSCPicker(
                              defaultCountry: CscCountry.India,
                              disableCountry: true,
                              onCountryChanged: (val) {
                                setState(() {
                                  value.country.text = val;
                                });
                              },
                              onStateChanged: (val) {
                                setState(() {
                                  value.state.text = val ?? '';
                                });
                              },
                              onCityChanged: (val) {
                                setState(() {
                                  value.city.text = val ?? '';
                                });
                              },
                            ),
                            const SizedBox(height: 15),
                            CommonTextFormField(
                                title: 'District',
                                fillColor: Colors.white,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'District cannot be empty';
                                  }
                                  return null;
                                },
                                controller: value.districtController),
                            const SizedBox(height: 15),
                            CommonTextFormField(
                                maxLength: 6,
                                title: 'Pincode',
                                fillColor: Colors.white,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Pincode cannot be empty';
                                  }
                                  return null;
                                },
                                controller: value.pinCodeController),
                            const SizedBox(height: 15),
                            CommonTextFormField(
                                maxLength: 10,
                                title: 'Mobile Number',
                                fillColor: Colors.white,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Mobile Number cannot be empty';
                                  }
                                  return null;
                                },
                                controller: value.mobileNumberController),
                            const SizedBox(height: 15),
                            CommonTextFormField(
                                maxLength: 12,
                                title: 'Aadhar Number',
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                fillColor: Colors.white,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Aadhar Number cannot be empty';
                                  }
                                  return null;
                                },
                                controller: value.aadharNumberController),
                            const SizedBox(height: 15),
                            CommonTextFormField(
                                maxLength: 10,
                                title: 'PAN Number',
                                fillColor: Colors.white,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'PAN Number cannot be empty';
                                  }
                                  return null;
                                },
                                controller: value.panNumberController),
                            const SizedBox(height: 15),
                            CommonTextFormField(
                                maxLength: 15,
                                title: 'GST Number',
                                fillColor: Colors.white,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'GST Number cannot be empty';
                                  }
                                  return null;
                                },
                                controller: value.gstNumberController),
                            const SizedBox(height: 15),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none),
                                  hintText: 'Mapped Principal Distributor'),
                              value: value.selectedDistributor,
                              items: value.pdList.map((GetPdResponse pd) {
                                return DropdownMenuItem<String>(
                                    value: pd.sId, child: Text(pd.name ?? ''));
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  value.selectedDistributor = newValue;
                                });
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mapped Principal Distributor cannot be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            Align(
                              alignment: Alignment.center,
                              child: CommonElevatedButton(
                                borderRadius: 30,
                                width: double.infinity,
                                height: kToolbarHeight - 10,
                                text: 'CONTINUE',
                                backgroundColor: const Color(0xff004791),
                                onPressed: () {
                                  if (value.retailerDetailsFormKey.currentState!
                                      .validate()) {
                                    value.tabController.animateTo(1);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

class CustomCountryStateCityPicker extends StatelessWidget {
  final TextEditingController country;
  final TextEditingController state;
  final TextEditingController city;
  final Color dialogColor;
  final InputDecoration textFieldDecoration;

  const CustomCountryStateCityPicker({
    super.key,
    required this.country,
    required this.state,
    required this.city,
    required this.dialogColor,
    required this.textFieldDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: country,
          decoration: textFieldDecoration.copyWith(
            labelText: 'Country',
            enabled: false,
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: state,
          decoration: textFieldDecoration.copyWith(labelText: 'State'),
          readOnly: true,
          onTap: () {
            // Implement state selection logic for India
          },
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: city,
          decoration: textFieldDecoration.copyWith(labelText: 'City'),
          readOnly: true,
          onTap: () {
            // Implement city selection logic based on selected state
          },
        ),
      ],
    );
  }
}
