import 'dart:io';
import 'package:cheminova/provider/collect_kyc_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/common_elevated_button.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({super.key});

  @override
  State<UploadDocumentScreen> createState() => UploadDocumentScreenState();
}

class UploadDocumentScreenState extends State<UploadDocumentScreen> {
  Widget _buildUploadButton(String title, File? file, bool isOptional) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title + (isOptional ? ' (optional)' : ''),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        /// Create a view for the selected file
        if (file != null)
          Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: file.path.endsWith('.jpg') || file.path.endsWith('.png')
                  ? Image.file(file, fit: BoxFit.cover)
                  : Center(
                      child: Text(file.path.split('/').last,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center)))
        else
          const Text('No file selected', style: TextStyle(color: Colors.red)),

        if (file != null)
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('File uploaded: ${file.path.split('/').last}')),

        const SizedBox(height: 8),
        Consumer<CollectKycProvider>(
          builder: (context, value, child) => CommonElevatedButton(
            borderRadius: 30,
            width: double.infinity,
            height: kToolbarHeight - 10,
            text: file == null ? 'Upload $title' : 'Change $title',
            backgroundColor: const Color(0xff004791),
            onPressed: () => value.showPicker(context, title),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CollectKycProvider>(
      builder: (context, value, child) => Padding(
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
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: const Color(0xffB4D1E5).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(26.0)),
                child: Consumer<CollectKycProvider>(
                  builder: (context, value, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildUploadButton('PAN Card', value.panCard, false),
                      _buildUploadButton(
                          'Aadhar Card', value.aadharCard, false),
                      _buildUploadButton(
                          'GST Registration', value.gstRegistration, false),
                      _buildUploadButton(
                          'Pesticide License', value.pesticideLicense, false),
                      _buildUploadButton(
                          'Fertilizer License', value.fertilizerLicense, true),
                      _buildUploadButton('Selfie of Entrance Board',
                          value.selfieEntranceBoard, false),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: CommonElevatedButton(
                          borderRadius: 30,
                          width: double.infinity,
                          height: kToolbarHeight - 10,
                          text: 'SUBMIT',
                          backgroundColor: const Color(0xff004791),
                          onPressed: () {
                            // Handle form submission
                            value.tabController.animateTo(2);
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
      ),
    );
  }
}
