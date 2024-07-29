import 'package:cheminova/provider/collect_kyc_provider.dart';
import 'package:flutter/material.dart';
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
                            CommonTextFormField(
                                title: 'Town/City',
                                fillColor: Colors.white,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Town/City cannot be empty';
                                  }
                                  return null;
                                },
                                controller: value.townCityController),
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
                                title: 'State',
                                fillColor: Colors.white,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'State cannot be empty';
                                  }
                                  return null;
                                },
                                controller: value.stateController),
                            const SizedBox(height: 15),
                            CommonTextFormField(
                              maxLength: 6,
                                title: 'Pincode',
                                fillColor: Colors.white,
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
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                labelText: 'Mapped Principal Distributor',
                              ),
                              value: value.selectedDistributor,
                              items:
                                  value.distributors.map((String distributor) {
                                return DropdownMenuItem<String>(
                                  value: distributor,
                                  child: Text(distributor),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  value.selectedDistributor = newValue;
                                });
                              },
                              validator: (String? value) {
                                if (value!.isEmpty) {
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
                                  // if (value.retailerDetailsFormKey.currentState!
                                  //     .validate()) {
                                    value.tabController.animateTo(1);
                              //    }
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
