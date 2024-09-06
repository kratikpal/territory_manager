import 'package:cheminova/models/pd_rd_response_model.dart';
import 'package:cheminova/models/task_model.dart';
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
  List<PdRdResponseModel> _pdList = [];
  List<PdRdResponseModel> _rdList = [];
  List<TaskModel> _taskModelList = [];
  PdRdResponseModel? _selectedDistributor;
  final TextEditingController _noteController = TextEditingController();
  final _apiClient = ApiClient();

  bool get isLoading => _isLoading;
  PdRdResponseModel? get selectedSalesCoordinator => _selectedSalesCoordinator;
  String? get selectedTask => _selectedTask;
  String? get selectedPriority => _selectedPriority;
  String get selectedDate => _selectedDate;
  List<PdRdResponseModel> get salesCoordinators => _salesCoordinators;
  TextEditingController get noteController => _noteController;
  List<PdRdResponseModel> get pdList => _pdList;
  List<PdRdResponseModel> get rdList => _rdList;
  List<TaskModel> get taskModelList => _taskModelList;
  PdRdResponseModel? get selectedDistributor => _selectedDistributor;

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

  void clear() {
    _selectedSalesCoordinator = null;
    _selectedTask = null;
    _selectedPriority = null;
    _selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _noteController.clear();
    _taskModelList.clear();
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

  Future<void> assignTask({
    required BuildContext context,
    String? selectedDistributorType,
  }) async {
    setLoading(true);

    try {
      final data = {
        'taskAssignedTo': _selectedSalesCoordinator!.id,
        'task': _selectedTask,
        'taskPriority': _selectedPriority,
        'taskDueDate': _selectedDate,
        if (_selectedTask == 'Collect KYC' || _selectedTask == 'Visit RD/PD')
          'note': _noteController.text,
      };

      if (selectedDistributorType != null &&
          selectedDistributorType.isNotEmpty) {
        data.addAll({
          'addedFor': selectedDistributorType,
          'addedForId': _selectedDistributor!.id,
          'tradename': selectedDistributorType == 'PrincipalDistributor'
              ? _selectedDistributor!.shippingAddress!.tradeName
              : _selectedDistributor!.tradeNameRd,
        });
      }

      Response response = await _apiClient.post(
        ApiUrls.assignTask,
        data: data,
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

  void clearLists() {
    _pdList.clear();
    _rdList.clear();
    notifyListeners();
  }

  void setSelectedDistributor(PdRdResponseModel? distributor) {
    _selectedDistributor = distributor;
    notifyListeners();
  }

  Future<void> getPd() async {
    setLoading(true);
    clearLists(); // Clear the list before fetching new data
    try {
      Response response = await _apiClient.get(ApiUrls.getPd);
      if (response.statusCode == 200) {
        List<PdRdResponseModel> data = (response.data as List)
            .map((json) => PdRdResponseModel.fromJson(json))
            .toList();
        _pdList = data;
        print("PDTradeName ${data[0].shippingAddress!.tradeName}");
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getRd() async {
    setLoading(true);
    clearLists(); // Clear the list before fetching new data
    try {
      Response response = await _apiClient.get(ApiUrls.getRd);
      if (response.statusCode == 200) {
        List<PdRdResponseModel> data = (response.data as List)
            .map((json) => PdRdResponseModel.fromJson(json))
            .toList();
        _rdList = data;
        print("RDTradeName ${data[0].tradeNameRd}");
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getNewTasks() async {
    setLoading(true);
    clearLists();
    try {
      Response response = await _apiClient.get("${ApiUrls.getAllTasks}New");
      if (response.statusCode == 200) {
        List<TaskModel> data = (response.data['tasks'] as List)
            .map((json) => TaskModel.fromJson(json))
            .toList();
        _taskModelList = data;
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getPendingTasks() async {
    setLoading(true);
    clearLists();
    try {
      Response response = await _apiClient.get("${ApiUrls.getAllTasks}Pending");
      if (response.statusCode == 200) {
        List<TaskModel> data = (response.data['tasks'] as List)
            .map((json) => TaskModel.fromJson(json))
            .toList();
        _taskModelList = data;
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getCompletedTasks() async {
    setLoading(true);
    clearLists();
    try {
      Response response =
          await _apiClient.get("${ApiUrls.getAllTasks}Completed");
      if (response.statusCode == 200) {
        List<TaskModel> data = (response.data['tasks'] as List)
            .map((json) => TaskModel.fromJson(json))
            .toList();
        _taskModelList = data;
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      setLoading(false);
    }
  }
}
