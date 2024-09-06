import 'package:cheminova/models/task_model.dart';
import 'package:cheminova/provider/task_provider.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskManagementScreen extends StatefulWidget {
  const TaskManagementScreen({super.key});

  @override
  State<TaskManagementScreen> createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<TaskModel> _filteredTaskList = [];
  String? _selectedChip = 'New'; // State to track the selected chip

  void _filterTaskList(String query) {
    if (query.isEmpty || query == '' || query == ' ') {
      setState(() {
        _filteredTaskList = context.read<TaskProvider>().taskModelList;
      });
      return;
    }
    setState(() {
      _filteredTaskList = _filteredTaskList
          .where((task) => task.taskAssignedTo.name
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _updateTaskProvider() async {
    final provider = context.read<TaskProvider>();
    provider.clear();
    await provider.getNewTasks();
    _filteredTaskList.clear();
    _filteredTaskList = provider.taskModelList;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateTaskProvider();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

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
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20.0)
                        .copyWith(top: 15, bottom: 30),
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
                                title: 'New',
                                icon: const Icon(Icons.new_releases),
                                onSelected: () async {
                                  setState(() {
                                    _selectedChip = 'New';
                                  });
                                  await taskProvider.getNewTasks();
                                  _filteredTaskList.clear();
                                  _filteredTaskList =
                                      taskProvider.taskModelList;
                                },
                                isSelected: _selectedChip == 'New',
                              ),
                              const SizedBox(width: 5),
                              _filterChip(
                                title: 'Pending',
                                icon: const Icon(Icons.pending),
                                onSelected: () async {
                                  setState(() {
                                    _selectedChip = 'Pending';
                                  });
                                  await taskProvider.getPendingTasks();
                                  _filteredTaskList.clear();
                                  _filteredTaskList =
                                      taskProvider.taskModelList;
                                },
                                isSelected: _selectedChip == 'Pending',
                              ),
                              const SizedBox(width: 5),
                              _filterChip(
                                title: 'Completed',
                                icon: const Icon(Icons.done),
                                onSelected: () async {
                                  setState(() {
                                    _selectedChip = 'Completed';
                                  });
                                  await taskProvider.getCompletedTasks();
                                  _filteredTaskList.clear();
                                  _filteredTaskList =
                                      taskProvider.taskModelList;
                                },
                                isSelected: _selectedChip == 'Completed',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: _filteredTaskList.isEmpty
                              ? const Center(child: Text('No tasks found'))
                              : ListView.builder(
                                  itemCount: _filteredTaskList.length,
                                  itemBuilder: (context, index) => _taskView(
                                    task: _filteredTaskList[
                                        _selectedChip == 'Completed'
                                            ? index
                                            : ((_filteredTaskList.length - 1) -
                                                index)],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (taskProvider.isLoading)
              Container(
                color: Colors.black.withOpacity(0.1),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _customContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: const Color(0xffB4D1E5).withOpacity(0.6),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: child,
    );
  }

  Widget _taskView({required TaskModel task}) {
    final formatedDate = DateFormat('dd/MM/yyyy').format(task.taskDueDate);
    return Column(
      children: [
        _customContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assigned to: ${task.taskAssignedTo.name}",
                style: const TextStyle(
                  fontFamily: 'Anek',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Task: ${task.task}",
                style: const TextStyle(
                  fontFamily: 'Anek',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Status: ${task.taskStatus}',
                style: const TextStyle(
                  fontFamily: 'Anek',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Deadline:$formatedDate',
                style: const TextStyle(
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

  Widget _filterChip({
    required String title,
    required Widget icon,
    required VoidCallback onSelected,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: onSelected,
      child: Chip(
        avatar: icon,
        label: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Anek',
          ),
        ),
        backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
      ),
    );
  }
}
