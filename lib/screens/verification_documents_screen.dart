import 'package:cheminova/provider/collect_kyc_provider.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyDocumentsScreen extends StatelessWidget {
  const VerifyDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CommonDrawer(),
      body: CommonBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<CollectKycProvider>(
                  builder: (BuildContext context, CollectKycProvider value,
                          Widget? child) =>
                      _buildSection(
                    'Retailer Details',
                    {
                      'Trade Name': value.tradeNameController.text,
                      'Name': value.nameController.text,
                      'Address': value.addressController.text,
                      'Town/City': value.city.text,
                      'District': value.districtController.text,
                      'State': value.state.text,
                      'Pincode': value.pinCodeController.text,
                      'Mobile Number': value.mobileNumberController.text,
                      'Aadhar Number': value.aadharNumberController.text,
                      'PAN Number': value.panNumberController.text,
                      'GST Number': value.gstNumberController.text,
                      'Mapped Principal Distributor':
                          value.selectedDistributor ?? '',
                    },
                    onEdit: () {
                      value.tabController.animateTo(0);
                      // Handle edit for retailer details
                      debugPrint('Edit retailer details');
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Consumer<CollectKycProvider>(
                  builder: (BuildContext context, CollectKycProvider value,
                          Widget? child) =>
                      _buildSection(
                    'Uploaded Documents',
                    {
                      'PAN Card':
                          value.panCard?.path.split('/').last ?? 'Not uploaded',
                      'Aadhar Card': value.aadharCard?.path.split('/').last ??
                          'Not uploaded',
                      'GST Registration':
                          value.gstRegistration?.path.split('/').last ??
                              'Not uploaded',
                      'Pesticide License':
                          value.pesticideLicense?.path.split('/').last ??
                              'Not uploaded',
                      'Fertilizer License':
                          value.fertilizerLicense?.path.split('/').last ??
                              'Not uploaded',
                      'Selfie of Entrance Board':
                          value.selfieEntranceBoard?.path.split('/').last ??
                              'Not uploaded',
                    },
                    onEdit: () {
                      value.tabController.animateTo(1);

                      // Handle edit for uploaded documents
                      debugPrint('Edit uploaded documents');
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: Consumer<CollectKycProvider>(
                    builder: (context, value, child) => CommonElevatedButton(
                      borderRadius: 30,
                      width: double.infinity,
                      height: kToolbarHeight - 10,
                      text: ('SAVE AND CONFIRM'),
                      backgroundColor: const Color(0xff004791),
                      onPressed: () {
                        // Handle final submission

                        value.validateFields(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Map<String, String> details,
      {required VoidCallback onEdit}) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      // margin: const EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: const Color(0xffB4D1E5).withOpacity(0.9),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: onEdit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFFFFFF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Edit'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...details.entries
              .map((entry) => _buildDetailRow(entry.key, entry.value)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              flex: 3,
              child: Text(
                value,
                style: TextStyle(
                    color: value == 'Not uploaded' ? Colors.red : Colors.black),
              )),
        ],
      ),
    );
  }
}
