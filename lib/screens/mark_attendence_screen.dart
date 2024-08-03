import 'package:cheminova/provider/attendance_provider.dart';
import 'package:cheminova/screens/Attendance_success.dart';
import 'package:cheminova/screens/on_leave_screen.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:cheminova/widgets/common_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  late AttendanceProvider attendanceProvider;
  final dateController = TextEditingController(
      text: DateFormat('yyyy/MM/dd').format(DateTime.now()));

  final timeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));

  final locationController = TextEditingController();
  final notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    attendanceProvider = AttendanceProvider();
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
      locationController.text = place.locality ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AttendanceProvider>(
      create: (_) => attendanceProvider,
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
            title: const Text('Mark Attendance',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Anek')),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          drawer: const CommonDrawer(),
          body: Stack(
            children: [
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
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
                            CommonTextFormField(
                                title: 'Location',
                                readOnly: true,
                                fillColor: Colors.white,
                                controller: locationController),
                            const SizedBox(height: 15),
                            CommonTextFormField(
                                height: 100,
                                title: 'Notes',
                                fillColor: Colors.white,
                                maxLines: 4,
                                controller: notesController),
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Consumer<AttendanceProvider>(
                                    builder: (BuildContext context,
                                            AttendanceProvider value,
                                            Widget? child) =>
                                        CommonElevatedButton(
                                            backgroundColor:
                                                const Color(0xff004791),
                                            borderRadius: 30,
                                            width: double.infinity,
                                            height: kToolbarHeight - 10,
                                            text: 'MARK ATTENDANCE',
                                            onPressed: () {
                                              value
                                                  .markAttendance(
                                                      dateController.text
                                                          .trim(),
                                                      timeController.text
                                                          .trim(),
                                                      locationController.text
                                                          .trim(),
                                                      notesController.text
                                                          .trim())
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
                                  ),
                                  const SizedBox(height: 15),
                                  CommonElevatedButton(
                                      borderRadius: 30,
                                      width: double.infinity,
                                      height: kToolbarHeight - 10,
                                      text: 'ON LEAVE',
                                      backgroundColor: const Color(0xff00784C),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const OnLeaveScreen(),
                                            ));
                                      })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Consumer<AttendanceProvider>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return Container(
                          color: Colors.black12,
                          child:
                              const Center(child: CircularProgressIndicator()));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
