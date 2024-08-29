import 'package:cheminova/models/pd_rd_response_model.dart';
import 'package:cheminova/provider/task_provider.dart';
import 'package:cheminova/screens/confirm_task_screen.dart';
import 'package:provider/provider.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';

class AssignTasksScreen extends StatefulWidget {
  const AssignTasksScreen({super.key});

  @override
  State<AssignTasksScreen> createState() => _AssignTasksScreenState();
}

class _AssignTasksScreenState extends State<AssignTasksScreen> {
  bool _isSalesCoordinatorValid = true;
  bool _isTaskValid = true;
  bool _isPriorityValid = true;
  bool _isNotesValid = true;
  bool _isDistributorValid = true;
  String? selectedDistributorType;

  void _validateAndSubmit() {
    final taskProvider = context.read<TaskProvider>();
    setState(() {
      // Validate Sales Coordinator
      _isSalesCoordinatorValid = taskProvider.selectedSalesCoordinator != null;

      // Validate Task
      _isTaskValid = taskProvider.selectedTask != null &&
          taskProvider.selectedTask!.isNotEmpty;

      // Validate Priority
      _isPriorityValid = taskProvider.selectedPriority != null &&
          taskProvider.selectedPriority!.isNotEmpty;

      // Validate Notes
      if ((taskProvider.selectedTask == 'Collect KYC' ||
              taskProvider.selectedTask == 'Visit RD/PD') &&
          taskProvider.noteController.text.isEmpty) {
        _isNotesValid = false;
      } else {
        _isNotesValid = true;
      }

      // Validate Distributor
      if ((taskProvider.selectedTask == 'Update Inventory Data' ||
              taskProvider.selectedTask == 'Visit RD/PD') &&
          (taskProvider.selectedDistributor == null ||
              selectedDistributorType == null)) {
        _isDistributorValid = false;
      } else {
        _isDistributorValid = true;
      }
    });

    // If all fields are valid, proceed to the next screen
    if (_isSalesCoordinatorValid &&
        _isTaskValid &&
        _isPriorityValid &&
        _isNotesValid &&
        _isDistributorValid) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmTaskScreen(
            selectedDistributorType: selectedDistributorType,
          ),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final provider = context.read<TaskProvider>();
    final dateSelected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (dateSelected != null) {
      provider.setDate(DateFormat('dd/MM/yyyy').format(dateSelected));
    }
  }

  void _updateTaskProvider() {
    final provider = context.read<TaskProvider>();
    provider.clear();
    provider.getSalesCoordinators();
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
            'Assign Tasks',
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
                        const Text(
                          'Assign Tasks',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Anek',
                          ),
                        ),
                        const SizedBox(height: 20),
                        SearchField(
                          suggestionsDecoration: SuggestionDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8),
                            ),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          suggestionItemDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                color: Colors.transparent,
                                style: BorderStyle.solid,
                                width: 1.0),
                          ),
                          searchInputDecoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.2),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            errorText: !_isSalesCoordinatorValid
                                ? 'Please select a Sales Coordinator'
                                : null,
                          ),
                          hint: 'Select Sales Coordinator',
                          onSuggestionTap: (selectedItem) {
                            if (selectedItem.item != null) {
                              taskProvider.setSelectedSalesCoordinator(
                                  selectedItem.item!);
                              FocusScope.of(context).unfocus();
                            }
                          },
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          marginColor: Colors.grey.shade300,
                          suggestions: taskProvider.salesCoordinators
                              .map(
                                (e) => SearchFieldListItem(
                                  e.name!,
                                  item: e,
                                  child: Text(e.name!),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: const Color(0xffB4D1E5).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tasks List:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Anek',
                                ),
                              ),
                              SizedBox(
                                height: 35,
                                child: RadioListTile<String>(
                                  contentPadding: EdgeInsets.zero,
                                  value: 'Visit RD/PD',
                                  groupValue: taskProvider.selectedTask,
                                  onChanged: (value) {
                                    taskProvider.setSelectedTask(value);
                                  },
                                  title: const Text(
                                    "Visit RD/PD",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                child: RadioListTile<String>(
                                  contentPadding: EdgeInsets.zero,
                                  value: 'Update Sales Data',
                                  groupValue: taskProvider.selectedTask,
                                  onChanged: (value) {
                                    taskProvider.setSelectedTask(value);
                                  },
                                  title: const Text(
                                    "Update Sales Data",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                child: RadioListTile<String>(
                                  contentPadding: EdgeInsets.zero,
                                  value: 'Update Inventory Data',
                                  groupValue: taskProvider.selectedTask,
                                  onChanged: (value) {
                                    taskProvider.setSelectedTask(value);
                                  },
                                  title: const Text(
                                    "Update Inventory Data",
                                  ),
                                ),
                              ),
                              RadioListTile<String>(
                                contentPadding: EdgeInsets.zero,
                                value: 'Collect KYC',
                                groupValue: taskProvider.selectedTask,
                                onChanged: (value) {
                                  taskProvider.setSelectedTask(value);
                                },
                                title: const Text(
                                  "Collect KYC",
                                ),
                              ),
                              if (!_isTaskValid &&
                                  (taskProvider.selectedTask?.isEmpty ?? true))
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    'Please select a task',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (taskProvider.selectedTask == 'Collect KYC' ||
                            taskProvider.selectedTask == 'Visit RD/PD') ...{
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: TextFormField(
                              controller: taskProvider.noteController,
                              expands: true,
                              maxLines: null,
                              minLines: null,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14.0,
                                  horizontal: 16.0,
                                ),
                                border: InputBorder.none,
                                labelText: 'Note',
                                hintText: 'Enter your note',
                                errorText: !_isNotesValid
                                    ? 'Please enter a note'
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        },
                        if (taskProvider.selectedTask ==
                                'Update Inventory Data' ||
                            taskProvider.selectedTask == 'Visit RD/PD') ...{
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 5,
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Select Distributor Type',
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                              ),
                              value: selectedDistributorType,
                              items: [
                                'PrincipalDistributor',
                                'RetailDistributor'
                              ].map((String type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedDistributorType = value;
                                  selectedDistributorType ==
                                          'PrincipalDistributor'
                                      ? taskProvider.getPd()
                                      : taskProvider.getRd();
                                  taskProvider.setSelectedDistributor(null);
                                });
                              },
                            ),
                          ),
                          // Dropdown for selecting distributor name based on type
                          if (selectedDistributorType != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 25),
                              child: DropdownButtonFormField<PdRdResponseModel>(
                                decoration: const InputDecoration(
                                  labelText: 'Select Distributor Name',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                ),
                                value: taskProvider.selectedDistributor,
                                items: (selectedDistributorType ==
                                            'PrincipalDistributor'
                                        ? taskProvider.pdList
                                        : taskProvider.rdList)
                                    .map((PdRdResponseModel distributor) {
                                  return DropdownMenuItem<PdRdResponseModel>(
                                    value: distributor,
                                    child: Text(distributor.name!),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  taskProvider.setSelectedDistributor(value);
                                },
                                isExpanded: true,
                                isDense: true,
                                iconSize: 24,
                                hint: Text(
                                    'Please select a ${selectedDistributorType ?? "Distributor Type"} first'),
                              ),
                            ),
                          if (!_isDistributorValid)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Please select a distributor',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        },
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: const Color(0xffB4D1E5).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Priority:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Anek',
                                ),
                              ),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: "Low",
                                    groupValue: taskProvider.selectedPriority,
                                    onChanged: (value) {
                                      taskProvider.setSelectedPriority(value!);
                                    },
                                  ),
                                  const Text("Low"),
                                  Radio<String>(
                                    value: "Medium",
                                    groupValue: taskProvider.selectedPriority,
                                    onChanged: (value) {
                                      taskProvider.setSelectedPriority(value!);
                                    },
                                  ),
                                  const Text("Medium"),
                                  Radio<String>(
                                    value: "High",
                                    groupValue: taskProvider.selectedPriority,
                                    onChanged: (value) {
                                      taskProvider.setSelectedPriority(value!);
                                    },
                                  ),
                                  const Text("High"),
                                ],
                              ),
                              if (!_isPriorityValid &&
                                  (taskProvider.selectedPriority?.isEmpty ??
                                      true))
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    'Please select a priority',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: const Color(0xffB4D1E5).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Due Date:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Anek',
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    taskProvider.selectedDate,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                    icon: const Icon(Icons.calendar_month),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CommonElevatedButton(
                          backgroundColor: const Color(0xff004791),
                          borderRadius: 30,
                          width: double.infinity,
                          height: kToolbarHeight - 10,
                          text: 'CONFIRM',
                          onPressed: _validateAndSubmit,
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
}
