import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignTasksScreen extends StatefulWidget {
  const AssignTasksScreen({super.key});

  @override
  State<AssignTasksScreen> createState() => _AssignTasksScreenState();
}

class _AssignTasksScreenState extends State<AssignTasksScreen> {
  final List<bool> _isChecked = List.generate(8, (_) => false);

  String _dateSelected = DateFormat('dd/MM/yyyy').format(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    final dateSelected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (dateSelected != null) {
      setState(() {
        _dateSelected = DateFormat('dd/MM/yyyy').format(dateSelected);
      });
    }
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
            'Assign Tasks',
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
                      'Assign Tasks',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Anek',
                      ),
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sales Coordinator: Name",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Anek',
                            ),
                          ),
                          Text(
                            "ID: 121",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Anek',
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
                            "Tasks List:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Anek',
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            child: CheckboxListTile(
                              value: _isChecked[0],
                              onChanged: (value) {
                                setState(() {
                                  _isChecked[0] = value!;
                                });
                              },
                              title: const Text(
                                "Visit Retailers",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            child: CheckboxListTile(
                              value: _isChecked[1],
                              onChanged: (value) {
                                setState(() {
                                  _isChecked[1] = value!;
                                });
                              },
                              title: const Text(
                                "Update Sales Data",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            child: CheckboxListTile(
                              value: _isChecked[2],
                              onChanged: (value) {
                                setState(() {
                                  _isChecked[2] = value!;
                                });
                              },
                              title: const Text(
                                "Update Liqudation Data",
                              ),
                            ),
                          ),
                          CheckboxListTile(
                            value: _isChecked[3],
                            onChanged: (value) {
                              setState(() {
                                _isChecked[3] = value!;
                              });
                            },
                            title: const Text(
                              "Collect KYC",
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
                            "Priority:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Anek',
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _isChecked[4],
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked[4] = value!;
                                  });
                                },
                              ),
                              const Text(
                                "Low",
                              ),
                              Checkbox(
                                value: _isChecked[5],
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked[5] = value!;
                                  });
                                },
                              ),
                              const Text(
                                "Medium",
                              ),
                              Checkbox(
                                value: _isChecked[6],
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked[6] = value!;
                                  });
                                },
                              ),
                              const Text(
                                "High",
                              ),
                            ],
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
                                _dateSelected,
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
                      onPressed: () {},
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
}
