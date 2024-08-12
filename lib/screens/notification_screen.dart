import 'package:cheminova/models/notification_list_response.dart';
import 'package:cheminova/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  late NotificationProvider _notificationProvider;

  @override
  void initState() {
    _notificationProvider = NotificationProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _notificationProvider,
      child: CommonBackground(
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
            title: const Text('Notification',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Anek')),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          drawer: const CommonDrawer(),
          body: Consumer<NotificationProvider>(
            builder: (context, value, child) => value.isLoading
                ? const Center(child: CircularProgressIndicator())
                : MyListView(value: value),
          ),
        ),
      ),
    );
  }
}

Widget buildProductButton(String productName) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: CommonElevatedButton(
      borderRadius: 30,
      width: double.infinity,
      height: kToolbarHeight - 10,
      text: productName,
      backgroundColor: const Color(0xff004791),
      onPressed: () {
        // Handle product button press
        debugPrint('$productName pressed');
      },
    ),
  );
}

class MyListView extends StatelessWidget {
  final NotificationProvider value;

  const MyListView({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    // Group notifications by date
    Map<String, List<Notifications>> groupedNotifications = {};

    for (var notification in value.notificationList) {
      String date = DateFormat("dd MMM yyyy")
          .format(DateTime.parse(notification.createdAt ?? ''));
      if (!groupedNotifications.containsKey(date)) {
        groupedNotifications[date] = [];
      }
      groupedNotifications[date]!.add(notification);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 15),
      itemCount: groupedNotifications.length,
      itemBuilder: (context, index) {
        String date = groupedNotifications.keys.elementAt(index);
        List<Notifications> notificationsForDate = groupedNotifications[date]!;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the date once
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  date,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              // Display notifications for the date
              ...notificationsForDate.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ExpansionTile(
                    collapsedBackgroundColor: Colors.white,
                    backgroundColor: Colors.white,
                    trailing: const SizedBox.shrink(),
                    title: Text(
                      item.title ?? '',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(item.msg ?? ''),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
