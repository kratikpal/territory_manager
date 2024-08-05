import 'package:cheminova/screens/assign_tasks_screen.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_text_form_field.dart';
import 'package:flutter/material.dart';

class SelectSalesCoordinatorScreen extends StatefulWidget {
  const SelectSalesCoordinatorScreen({super.key});

  @override
  State<SelectSalesCoordinatorScreen> createState() =>
      _SelectSalesCoordinatorScreenState();
}

class _SelectSalesCoordinatorScreenState
    extends State<SelectSalesCoordinatorScreen> {
  List<SalesCoordinatorModel> salesCoordinators = [
    SalesCoordinatorModel(name: 'Sales Coordinator 1', id: '121', tasks: 2),
    SalesCoordinatorModel(name: 'Sales Coordinator 2', id: '122', tasks: 3),
    SalesCoordinatorModel(name: 'Sales Coordinator 3', id: '123', tasks: 4),
  ];
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
            'Sales Coordinator',
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
                  const Text(
                    'Select Sales Coordinator',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Anek',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CommonTextFormField(
                    title: 'Search Sales Coordinator',
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: salesCoordinators.length,
                      itemBuilder: (context, index) {
                        return _customCard(
                          name: salesCoordinators[index].name,
                          id: salesCoordinators[index].id,
                          tasks: salesCoordinators[index].tasks,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customCard(
      {required String name, required String id, required int tasks}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const AssignTasksScreen();
            },
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: const Color(0xffB4D1E5).withOpacity(0.6),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'Anek',
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "ID: $id",
              style: const TextStyle(
                fontFamily: 'Anek',
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Tasks: $tasks",
              style: const TextStyle(
                fontFamily: 'Anek',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesCoordinatorModel {
  final String name;
  final String id;
  final int tasks;

  SalesCoordinatorModel({
    required this.name,
    required this.id,
    required this.tasks,
  });
}
