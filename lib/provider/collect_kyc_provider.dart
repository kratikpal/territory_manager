import 'package:flutter/material.dart';

class CollectKycProvider extends ChangeNotifier {
  late TabController tabController;

  final tradeNameController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final townCityController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final aadharNumberController = TextEditingController();
  final panNumberController = TextEditingController();
  final gstNumberController = TextEditingController();
  String? selectedDistributor;
  final List<String> distributors = [
    'Distributor 1',
    'Distributor 2',
    'Distributor 3',
    'Distributor 4',
  ];
  final List<String> distributorIds = [
    'Distributor 1',
    'Distributor 2',
    'Distributor 3',
    'Distributor 4',
  ];
  final List<String> distributorNames = [
    'Distributor 1',
    'Distributor 2',
    'Distributor 3',
    'Distributor 4',
  ];
  final List<String> distributorAddresses = [
    'Distributor 1',
    'Distributor 2',
    'Distributor 3',
    'Distributor 4',
  ];
  final List<String> distributorMobileNumbers = [
    'Distributor 1',
    'Distributor 2',
    'Distributor 3',
    'Distributor 4',
  ];
  final List<String> distributorEmails = [
    'Distributor 1',
    'Distributor 2',
    'Distributor 3',
    'Distributor 4',
  ];
  final List<String> distributorGstNumbers = [
    'Distributor 1',
    'Distributor 2',
    'Distributor 3',
    'Distributor 4',
  ];
  final List<String> distributorPanNumbers = [
    'Distributor 1',
    'Distributor 2',
    'Distributor 3',
    'Distributor 4',
  ];
  final List<String> distributorAadharNumbers = [
    'Distributor 1',
    'Distributor 2',
    'Distributor 3',
    'Distributor 4',
  ];
  final List<String> distributorPinCodes = [
    'Distributor 1',
    'Distributor 2',
    'Distributor 3',
    'Distributor 4',
  ];

  final retailerDetailsFormKey = GlobalKey<FormState>();
}
