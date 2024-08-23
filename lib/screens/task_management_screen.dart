import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_text_form_field.dart';
import 'package:flutter/material.dart';

class TaskManagementScreen extends StatefulWidget {
  const TaskManagementScreen({super.key});

  @override
  State<TaskManagementScreen> createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _taskList = [
    'Task 1',
    'Task 2',
    'Task 3',
    'Task 4',
    'Task 5',
    'Task 6',
    'Task 7',
    'Task 8',
    'Task 9',
    'Task 10',
  ];

  final List<String> _filters = [
    'All',
    'Pending',
    'Completed',
  ];

  List<String> _filteredTaskList = [];

  void _filterTaskList(String query) {
    setState(() {
      _filteredTaskList = _taskList
          .where((task) => task.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _filteredTaskList = _taskList;
  }

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
            'Task Management',
            style: TextStyle(color: Colors.black87, fontSize: 20),
          ),
        ),
      ),
      drawer: const CommonDrawer(),
      body: CommonBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                padding:
                    const EdgeInsets.all(20.0).copyWith(top: 15, bottom: 30),
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
                    CommonTextFormField(
                      controller: _searchController,
                      onChanged: (value) => _filterTaskList(value),
                      title: 'Filter by Sales Coordinator:',
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _filterChip(
                            title: 'All',
                            icon: const Icon(Icons.all_inclusive),
                          ),
                          const SizedBox(width: 5),
                          _filterChip(
                            title: 'Pending',
                            icon: const Icon(Icons.pending),
                          ),
                          const SizedBox(width: 5),
                          _filterChip(
                            title: 'Completed',
                            icon: const Icon(Icons.done),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Tasks:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Anek',
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: ListView.builder(
                        itemCount: _filteredTaskList.length,
                        itemBuilder: (context, index) => _taskView(
                          title: _filteredTaskList[index],
                        ),
                      ),
                    ),
                    // CommonElevatedButton(
                    //   backgroundColor: const Color(0xff004791),
                    //   borderRadius: 30,
                    //   width: double.infinity,
                    //   height: kToolbarHeight - 10,
                    //   text: 'EDIT',
                    //   onPressed: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const AssignTasksScreen(),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    // CommonElevatedButton(
                    //   backgroundColor: const Color(0xff00784C),
                    //   borderRadius: 30,
                    //   width: double.infinity,
                    //   height: kToolbarHeight - 10,
                    //   text: 'REASSIGN',
                    //   onPressed: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) =>
                    //           const SelectSalesCoordinatorScreen(),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    // CommonElevatedButton(
                    //   backgroundColor: const Color(0xff00784C),
                    //   borderRadius: 30,
                    //   width: double.infinity,
                    //   height: kToolbarHeight - 10,
                    //   text: 'MARK AS COMPLETED',
                    //   onPressed: () {},
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      // margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: const Color(0xffB4D1E5).withOpacity(0.6),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: child,
    );
  }

  Widget _taskView({required String title}) {
    return Column(
      children: [
        _customContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sales Coordinator: 1',
                style: TextStyle(
                  fontFamily: 'Anek',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Anek',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Status: Pending',
                style: TextStyle(
                  fontFamily: 'Anek',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Deadline: 12/12/2024',
                style: TextStyle(
                  fontFamily: 'Anek',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _filterChip({required String title, required Widget icon}) {
    return Chip(
      avatar: icon,
      label: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Anek',
        ),
      ),
    );
  }
}
