import 'package:cheminova/widgets/common_background.dart';
import 'package:flutter/material.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/common_elevated_button.dart';
import '../widgets/common_text_form_field.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {

    return CommonBackground(
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
          title: const Text('Notifications',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Anek')),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0).copyWith(top: 20, bottom: 30),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: const Color(0xffB4D1E5).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(26.0),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Notifications',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Anek',
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(height:15 ),
                    CommonTextFormField(
                        title: ' Notification Type:Alert',
                    ),
                    SizedBox(height: 20,),

                ])
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(20.0).copyWith(top: 20, bottom: 30),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: const Color(0xffB4D1E5).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(26.0),
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text('Notifications List',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Anek',
                          )),
                      const SizedBox(height: 10),
                      const CommonTextFormField(
                        title: 'Task: Review Sales Data by EOD\nDate: 10-06-2024',),
                      const SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.center,
                        child: CommonElevatedButton(
                          borderRadius: 30,
                          width: double.infinity,
                          height: kToolbarHeight - 10,
                          text: 'VIEW DETAILS',
                          backgroundColor: const Color(0xff004791),
                          onPressed: () {
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const CommonTextFormField(
                        title: 'Alert: New Dealer Assigned\nDate: 10-06-2024',),
                       const SizedBox(height: 15),
                      Align(
                          alignment: Alignment.center,
                          child: CommonElevatedButton(
                              borderRadius: 30,
                              width: double.infinity,
                              height: kToolbarHeight - 10,
                              text: 'VIEW DETAILS',
                              backgroundColor: const Color(0xff004791),
                              onPressed: () {

                              },
                      ),
                    ),
              ],
          ),
        ),
      ]),
    )));
  }
}
