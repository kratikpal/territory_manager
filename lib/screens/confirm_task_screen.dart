import 'package:cheminova/provider/task_provider.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmTaskScreen extends StatefulWidget {
  final String? selectedDistributorType;
  const ConfirmTaskScreen({
    super.key,
    this.selectedDistributorType,
  });

  @override
  State<ConfirmTaskScreen> createState() => _ConfirmTaskScreenState();
}

class _ConfirmTaskScreenState extends State<ConfirmTaskScreen> {
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
            'Confirm Task',
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
                    const Text(
                      'Confirm Task',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Anek',
                      ),
                    ),
                    const SizedBox(height: 20),
                    _customContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sales Coordinator:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Anek',
                            ),
                          ),
                          Text(
                            taskProvider.selectedSalesCoordinator!.name!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Anek',
                            ),
                          ),
                          Text(
                            'ID: ${taskProvider.selectedSalesCoordinator!.uniqueId!}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Anek',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tasks:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Anek',
                      ),
                    ),
                    const SizedBox(height: 10),
                    _customContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Task: ${taskProvider.selectedTask!}',
                            style: const TextStyle(
                              fontFamily: 'Anek',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Priority: ${taskProvider.selectedPriority!}',
                            style: const TextStyle(
                              fontFamily: 'Anek',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Deadline: ${taskProvider.selectedDate}',
                            style: const TextStyle(
                              fontFamily: 'Anek',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (taskProvider.selectedTask == 'Collect KYC' ||
                        taskProvider.selectedTask == 'Visit RD/PD')
                      _customContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Note:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Anek',
                              ),
                            ),
                            Text(
                              taskProvider.noteController.text,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Anek',
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 20),
                    if (taskProvider.selectedTask != 'Collect KYC') ...{
                      _customContainer(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectedDistributorType!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Anek',
                            ),
                          ),
                          Text(
                            taskProvider.selectedDistributor!.name!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Anek',
                            ),
                          ),
                        ],
                      )),
                    },
                    const SizedBox(height: 20),
                    CommonElevatedButton(
                      isLoading: taskProvider.isLoading,
                      backgroundColor: const Color(0xff004791),
                      borderRadius: 30,
                      width: double.infinity,
                      height: kToolbarHeight - 10,
                      text: 'CONFIRM',
                      onPressed: () => taskProvider.assignTask(
                        context: context,
                        selectedDistributorType:
                            widget.selectedDistributorType != null
                                ? widget.selectedDistributorType!
                                : '',
                      ),
                    ),
                    const SizedBox(height: 20),
                    CommonElevatedButton(
                      backgroundColor: const Color(0xff00784C),
                      borderRadius: 30,
                      width: double.infinity,
                      height: kToolbarHeight - 10,
                      text: 'EDIT',
                      onPressed: () => Navigator.pop(context),
                    ),
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
}
