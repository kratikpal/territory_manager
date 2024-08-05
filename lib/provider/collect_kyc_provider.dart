import 'dart:io';

import 'package:cheminova/models/get_pd_response.dart';
import 'package:cheminova/screens/data_submit_successfull.dart';
import 'package:cheminova/services/api_client.dart';
import 'package:cheminova/services/secure__storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_urls.dart';

class CollectKycProvider extends ChangeNotifier {
  CollectKycProvider() {
    getPd();
  }

  TextEditingController country = TextEditingController(text: "India");
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  late TabController tabController;
  final _apiClient = ApiClient();
  final tradeNameController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final townCityController = TextEditingController();
  final districtController = TextEditingController();
  final pinCodeController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final aadharNumberController = TextEditingController();
  final panNumberController = TextEditingController();
  final gstNumberController = TextEditingController();

  String? selectedDistributor;

  final retailerDetailsFormKey = GlobalKey<FormState>();

  File? panCard;
  File? aadharCard;
  File? gstRegistration;
  File? pesticideLicense;
  File? fertilizerLicense;
  File? selfieEntranceBoard;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source, String documentType) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      switch (documentType) {
        case 'PAN Card':
          panCard = File(pickedFile.path);
          break;
        case 'Aadhar Card':
          aadharCard = File(pickedFile.path);
          break;
        case 'GST Registration':
          gstRegistration = File(pickedFile.path);
          break;
        case 'Pesticide License':
          pesticideLicense = File(pickedFile.path);
          break;
        case 'Fertilizer License':
          fertilizerLicense = File(pickedFile.path);
          break;
        case 'Selfie of Entrance Board':
          selfieEntranceBoard = File(pickedFile.path);
          break;
      }
    }
    notifyListeners();
  }

  void showPicker(BuildContext context, String documentType) {
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
                      pickImage(ImageSource.gallery, documentType);
                      Navigator.of(context).pop();
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    pickImage(ImageSource.camera, documentType);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  // Add methods for state and city selection if needed
  void selectState(String selectedState) {
    state.text = selectedState;
    notifyListeners();
  }

  void selectCity(String selectedCity) {
    city.text = selectedCity;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<GetPdResponse> pdList = [];

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> getPd() async {
    setLoading(true);
    try {
      Response response = await _apiClient.get(ApiUrls.getPdUrl);
      setLoading(false);
      if (response.statusCode == 200) {
        pdList = (response.data as List)
            .map((e) => GetPdResponse.fromJson(e))
            .toList();

        print('pd list length: ${pdList.length}');
      } else {}
    } catch (e) {
      setLoading(false);
    }
  }

  void validateFields(BuildContext context) {
    if (tradeNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Trade Name is required')),
      );
    } else if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name is required')),
      );
    } else if (addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Address is required')),
      );
    } else if (city.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Town/City is required')),
      );
    } else if (districtController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('District is required')),
      );
    } else if (state.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('State is required')),
      );
    } else if (pinCodeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pincode is required')),
      );
    } else if (mobileNumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mobile Number is required')),
      );
    } else if (aadharNumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aadhar Number is required')),
      );
    } else if (panNumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PAN Number is required')),
      );
    } else if (gstNumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('GST Number is required')),
      );
    } else if ((selectedDistributor ?? '').isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Mapped Principal Distributor is required')),
      );
    } else if (panCard == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PAN Card is required')),
      );
    } else if (aadharCard == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aadhar Card is required')),
      );
    } else if (gstRegistration == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('GST Registration is required')),
      );
    } else if (pesticideLicense == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pesticide License is required')),
      );
    } else if (selfieEntranceBoard == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selfie of Entrance Board is required')),
      );
    } else {
      submitCollectKycForm(context);
    }
  }

  Future<void> submitCollectKycForm(BuildContext context) async {
    final dio = Dio();
    final token = await SecureStorageService().read(key: 'access_token');
    final headers = {'Authorization': 'Bearer $token'};

    // Construct the FormData
    final data = FormData.fromMap({
      'name': nameController.text.trim(),
      'trade_name': tradeNameController.text.trim(),
      'address': addressController.text.trim(),
      'state': state.text.trim(),
      'city': city.text.trim(),
      'district': districtController.text.trim(),
      'pincode': pinCodeController.text.trim(),
      'mobile_number': mobileNumberController.text.trim(),
      'principal_distributer': selectedDistributor,
      'pan_number': panNumberController.text.trim(),
      'aadhar_number': aadharNumberController.text.trim(),
      'gst_number': gstNumberController.text.trim(),
      if (panCard != null)
        'pan_img': await MultipartFile.fromFile(panCard!.path, filename: 'pan_card.jpg'),
      if (aadharCard != null)
        'aadhar_img': await MultipartFile.fromFile(aadharCard!.path, filename: 'aadhar_card.jpg'),
      if (gstRegistration != null)
        'gst_img': await MultipartFile.fromFile(gstRegistration!.path, filename: 'gst_registration.jpg'),
      if (pesticideLicense != null)
        'pesticide_license_img': await MultipartFile.fromFile(pesticideLicense!.path, filename: 'pesticide_license.jpg'),
      if (selfieEntranceBoard != null)
        'selfie_entrance_img': await MultipartFile.fromFile(selfieEntranceBoard!.path, filename: 'selfie_entrance_board.jpg'),
    });

    setLoading(true);
    try {

      Response response = await _apiClient.post(ApiUrls.createCollectKycUrl,
          data: data);

      setLoading(false);

      if (response.data['success'] == true) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(response.data['message'].toString())));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DataSubmitSuccessfull()));
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Submission failed: ${response.statusMessage}')));
        }
      }
    } catch (e) {
      setLoading(false);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
      }
    }
  }
}