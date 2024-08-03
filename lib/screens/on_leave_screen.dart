import 'package:cheminova/provider/mark_leave_provider.dart';
import 'package:cheminova/screens/Attendance_success.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/common_elevated_button.dart';
import '../widgets/common_text_form_field.dart';

class OnLeaveScreen extends StatefulWidget {
  const OnLeaveScreen({super.key});

  @override
  State<OnLeaveScreen> createState() => _OnLeaveScreenState();
}

class _OnLeaveScreenState extends State<OnLeaveScreen> {
  late MarkLeaveProvider _markLeaveProvider;

  final dateController = TextEditingController(
      text: DateFormat('yyyy/MM/dd').format(DateTime.now()));

  final timeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));

  final locationController = TextEditingController();
  final notesController = TextEditingController();

  String selectedLeaveType = 'Sick';

  void onLeaveTypeSelected(String leaveType) {
    setState(() {
      selectedLeaveType = leaveType;
    });
  }

  Widget buildLeaveTypeOption(String leaveType) {
    bool isSelected = leaveType == selectedLeaveType;

    return GestureDetector(
      onTap: () => onLeaveTypeSelected(leaveType),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            leaveType,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _markLeaveProvider = MarkLeaveProvider();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('location denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        debugPrint('Location permissions are permanently denied');
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    debugPrint('position--- $position');

    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude)
            .timeout(const Duration(seconds: 10));
    debugPrint('place mark--- $placeMarks');

    Placemark place = placeMarks[0];
    setState(() {
      locationController.text = '${place.subLocality}, ${place.locality}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MarkLeaveProvider>(
        create: (_) => _markLeaveProvider,
        builder: (context, child) => CommonBackground(
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
                  title: const Text('On Leave',
                      style: TextStyle(
                          fontSize: 28,
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
                          padding: const EdgeInsets.all(20.0)
                              .copyWith(top: 30, bottom: 30),
                          margin: const EdgeInsets.symmetric(horizontal: 30.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              color: const Color(0xffB4D1E5).withOpacity(0.9),
                              borderRadius: BorderRadius.circular(26.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CommonTextFormField(
                                  title: 'Date',
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
                              const Text('Leave type',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Anek')),
                              const SizedBox(height: 3),
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  buildLeaveTypeOption('Sick'),
                                  const SizedBox(width: 10),
                                  buildLeaveTypeOption('Personal'),
                                  const SizedBox(width: 10),
                                  buildLeaveTypeOption('Privilege '),
                                ],
                              ),
                              const SizedBox(height: 15),
                              CommonTextFormField(
                                  height: 100,
                                  title: 'Reason',
                                  fillColor: Colors.white,
                                  maxLines: 4,
                                  controller: notesController),
                              const SizedBox(height: 16),
                              Align(
                                  alignment: Alignment.center,
                                  child: Consumer<MarkLeaveProvider>(
                                    builder: (context, value, child) =>
                                        CommonElevatedButton(
                                            borderRadius: 30,
                                            width: double.infinity,
                                            height: kToolbarHeight - 10,
                                            text: 'ON LEAVE',
                                            backgroundColor:
                                                const Color(0xff00784C),
                                            onPressed: () {
                                              value
                                                  .markLeave(
                                                      dateController.text
                                                          .trim(),
                                                      timeController.text
                                                          .trim(),
                                                      locationController.text
                                                          .trim(),
                                                      notesController.text
                                                          .trim(),
                                                      selectedLeaveType)
                                                  .then(
                                                (result) {
                                                  var (status, message) =
                                                      result;
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content:
                                                              Text(message)));
                                                  if (status) {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const AttendanceSuccess()));
                                                  }
                                                },
                                              );

                                              // Navigator.push(context, MaterialPageRoute(builder:(context) => const AttendanceSuccess(),));
                                            }),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
