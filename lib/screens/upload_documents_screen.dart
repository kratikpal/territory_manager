import 'dart:io';
import 'package:cheminova/provider/collect_kyc_provider.dart';
import 'package:cheminova/screens/data_submit_successfull.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/common_elevated_button.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({super.key});

  @override
  State<UploadDocumentScreen> createState() => UploadDocumentScreenState();
}

class UploadDocumentScreenState extends State<UploadDocumentScreen> {
  File? _panCard;
  File? _aadharCard;
  File? _gstRegistration;
  File? _pesticideLicense;
  File? _fertilizerLicense;
  File? _selfieEntranceBoard;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, String documentType) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        switch (documentType) {
          case 'PAN Card':
            _panCard = File(pickedFile.path);
            break;
          case 'Aadhar Card':
            _aadharCard = File(pickedFile.path);
            break;
          case 'GST Registration':
            _gstRegistration = File(pickedFile.path);
            break;
          case 'Pesticide License':
            _pesticideLicense = File(pickedFile.path);
            break;
          case 'Fertilizer License':
            _fertilizerLicense = File(pickedFile.path);
            break;
          case 'Selfie of Entrance Board':
            _selfieEntranceBoard = File(pickedFile.path);
            break;
        }
      }
    });
  }

  void _showPicker(BuildContext context, String documentType) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                if (documentType != 'Selfie of Entrance Board')
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _pickImage(ImageSource.gallery, documentType);
                      Navigator.of(context).pop();
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _pickImage(ImageSource.camera, documentType);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _buildUploadButton(String title, File? file, bool isOptional) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title + (isOptional ? ' (optional)' : ''),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        CommonElevatedButton(
          borderRadius: 30,
          width: double.infinity,
          height: kToolbarHeight - 10,
          text: file == null ? 'Upload $title' : 'Change $title',
          backgroundColor: const Color(0xff004791),
          onPressed: () => _showPicker(context, title),
        ),
        if (file != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('File uploaded: ${file.path.split('/').last}'),
          ),
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CollectKycProvider>(
      builder: (context, value, child) =>  Padding(
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
                    borderRadius: BorderRadius.circular(26.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildUploadButton('PAN Card', _panCard, false),
                    _buildUploadButton('Aadhar Card', _aadharCard, false),
                    _buildUploadButton('GST Registration', _gstRegistration, false),
                    _buildUploadButton('Pesticide License', _pesticideLicense, false),
                    _buildUploadButton('Fertilizer License', _fertilizerLicense, true),
                    _buildUploadButton('Selfie of Entrance Board', _selfieEntranceBoard, false),
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
                          value.tabController.animateTo(2);                      },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}