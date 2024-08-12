import 'dart:io';
import 'package:cheminova/provider/collect_kyc_provider.dart';
import 'package:cheminova/screens/retailer_details_screen.dart';
import 'package:cheminova/screens/upload_documents_screen.dart';
import 'package:cheminova/screens/verification_documents_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:provider/provider.dart';
import '../widgets/common_app_bar.dart';

class CollectKycScreen extends StatefulWidget {
  const CollectKycScreen({super.key});

  @override
  State<CollectKycScreen> createState() => CollectKycScreenState();
}

class CollectKycScreenState extends State<CollectKycScreen>
    with SingleTickerProviderStateMixin {
  late CollectKycProvider collectKycProvider;

  final _pages = [
    const RetailerDetailsScreen(),
    const UploadDocumentScreen(),
    const VerifyDocumentsScreen()
  ];

  @override
  void initState() {
    collectKycProvider = CollectKycProvider();
    collectKycProvider.tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  final locationController = TextEditingController();
  final notesController = TextEditingController();
  final dealerController = TextEditingController();
  final productController = TextEditingController();
  final qualityController = TextEditingController();
  final marketNameController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final aadharcardController = TextEditingController();
  final pancardController = TextEditingController();

  File? _selfieImage;
  File? _pesticideLicenseImage;
  File? _fertilizerLicenseImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, bool isSelfie) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        if (isSelfie) {
          _selfieImage = File(pickedFile.path);
        }
      }
    });
  }

  Future<void> _pickLicenseImage(ImageSource source, bool isPesticide) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        if (isPesticide) {
          _pesticideLicenseImage = File(pickedFile.path);
        } else {
          _fertilizerLicenseImage = File(pickedFile.path);
        }
      }
    });
  }

  void _showPicker(BuildContext context, bool isSelfie) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _pickImage(ImageSource.gallery, isSelfie);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _pickImage(ImageSource.camera, isSelfie);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void _showLicensePicker(BuildContext context, bool isPesticide) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _pickLicenseImage(ImageSource.gallery, isPesticide);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _pickLicenseImage(ImageSource.camera, isPesticide);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => collectKycProvider,
      child: Consumer<CollectKycProvider>(
        builder: (BuildContext context, value, Widget? child) => Stack(
          children: [
            CommonBackground(
              child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(100),
                    child: CommonAppBar(
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Image.asset('assets/Back_attendance.png'),
                          padding: const EdgeInsets.only(right: 20),
                        ),
                      ],
                      title: const Text('Collect KYC Data',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Anek')),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      bottom: TabBar(
                        controller: value.tabController,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.yellow,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        tabs: const [
                          Tab(text: 'Details'),
                          Tab(text: 'Documents'),
                          Tab(text: 'Verify')
                        ],
                      ),
                    ),
                  ),
                  drawer: const CommonDrawer(),
                  body: TabBarView(
                      controller: value.tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: _pages),
                ),
              ),
            ),
            if (value.isLoading)
              Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()))
          ],
        ),
      ),
    );
  }
}
