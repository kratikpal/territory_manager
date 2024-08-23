import 'package:cheminova/screens/assign_tasks_screen.dart';
import 'package:cheminova/screens/task_management_screen.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:flutter/material.dart';

class AssignTaskDashBoardScreen extends StatefulWidget {
  const AssignTaskDashBoardScreen({super.key});

  @override
  State<AssignTaskDashBoardScreen> createState() =>
      _AssignTaskDashBoardScreenState();
}

class _AssignTaskDashBoardScreenState extends State<AssignTaskDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonAppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/Back_attendance.png'),
            padding: const EdgeInsets.only(right: 20),
          ),
        ],
        title: const Center(
          child: Text(
            'Assign Tasks',
            style: TextStyle(color: Colors.black87, fontSize: 20),
          ),
        ),
      ),
      drawer: const CommonDrawer(),
      body: CommonBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              padding: const EdgeInsets.all(20.0).copyWith(top: 15, bottom: 30),
              margin: const EdgeInsets.symmetric(horizontal: 30.0)
                  .copyWith(bottom: 50),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: const Color(0xffB4D1E5).withOpacity(0.5),
                borderRadius: BorderRadius.circular(26.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text(
                  //   'Assign Tasks',
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     color: Colors.white,
                  //     fontWeight: FontWeight.bold,
                  //     fontFamily: 'Anek',
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     SizedBox(
                  //       height: 200,
                  //       width: MediaQuery.of(context).size.width / 4.2,
                  //       child:
                  //           _customCard(title: "Total Tasks", subtitle: "100"),
                  //     ),
                  //     SizedBox(
                  //       height: 200,
                  //       width: MediaQuery.of(context).size.width / 4.2,
                  //       child: _customCard(
                  //           title: "Tasks Pending", subtitle: "100"),
                  //     ),
                  //     SizedBox(
                  //       height: 200,
                  //       width: MediaQuery.of(context).size.width / 4.2,
                  //       child: _customCard(
                  //           title: "Reports Submitted", subtitle: "100"),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  CommonElevatedButton(
                    backgroundColor: const Color(0xff004791),
                    borderRadius: 30,
                    width: double.infinity,
                    height: kToolbarHeight - 10,
                    text: 'ASSIGN TASKS',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AssignTasksScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  CommonElevatedButton(
                    backgroundColor: const Color(0xff004791),
                    borderRadius: 30,
                    width: double.infinity,
                    height: kToolbarHeight - 10,
                    text: 'VIEW TASK STATUS',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TaskManagementScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  CommonElevatedButton(
                    backgroundColor: const Color(0xff004791),
                    borderRadius: 30,
                    width: double.infinity,
                    height: kToolbarHeight - 10,
                    text: 'MANAGE SCs',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customCard({required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(8.0).copyWith(top: 15, bottom: 30),
      margin: const EdgeInsets.all(4).copyWith(bottom: 30),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: const Color(0xffB4D1E5).withOpacity(0.6),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Anek',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 34,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Anek',
            ),
          ),
        ],
      ),
    );
  }
}
