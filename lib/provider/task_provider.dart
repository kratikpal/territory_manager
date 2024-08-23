import 'package:cheminova/models/pd_rd_response_model.dart';
import 'package:cheminova/screens/data_submit_successfull.dart';
import 'package:cheminova/services/api_client.dart';
import 'package:cheminova/services/api_urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskProvider extends ChangeNotifier {
  bool _isLoading = false;
  PdRdResponseModel? _selectedSalesCoordinator;
  String? _selectedTask;
  String? _selectedPriority;
  String _selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  List<PdRdResponseModel> _salesCoordinators = [];
  final TextEditingController _noteController = TextEditingController();
  final _apiClient = ApiClient();

  bool get isLoading => _isLoading;
  PdRdResponseModel? get selectedSalesCoordinator => _selectedSalesCoordinator;
  String? get selectedTask => _selectedTask;
  String? get selectedPriority => _selectedPriority;
  String get selectedDate => _selectedDate;
  List<PdRdResponseModel> get salesCoordinators => _salesCoordinators;
  TextEditingController get noteController => _noteController;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setSelectedSalesCoordinator(PdRdResponseModel coordinator) {
    _selectedSalesCoordinator = coordinator;
    notifyListeners();
  }

  void setSelectedTask(String? task) {
    _selectedTask = task;
    notifyListeners();
  }

  void setSelectedPriority(String priority) {
    _selectedPriority = priority;
    notifyListeners();
  }

  void setDate(String date) {
    _selectedDate = date;
    notifyListeners();
  }

  void clear(){
    _selectedSalesCoordinator = null;
    _selectedTask = null;
    _selectedPriority = null;
    _selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _noteController.clear();
    notifyListeners();
  }

  Future<void> getSalesCoordinators() async {
    setLoading(true);
    try {
      Response response = await _apiClient.get(ApiUrls.getSalesCoordinators);
      if (response.statusCode == 200) {
        List<PdRdResponseModel> data =
            (response.data['salesCoOrinators'] as List)
                .map((json) => PdRdResponseModel.fromJson(json))
                .toList();
        _salesCoordinators = data;
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
      setLoading(false);
    } finally {
      setLoading(false);
    }
  }

  Future<void> assignTask(BuildContext context) async {
    setLoading(true);
    try {
      Response response = await _apiClient.post(
        ApiUrls.assignTask,
        data: {
          'taskAssignedTo': _selectedSalesCoordinator!.id,
          'task': _selectedTask,
          'taskPriority': _selectedPriority,
          'taskDueDate': _selectedDate,
          'note': _noteController.text,
        },
      );
      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DataSubmitSuccessfull(),
          ),
        );
      } else {
        print("Failed to assign task: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      setLoading(false);
    }
  }
}
