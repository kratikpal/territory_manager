import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/api_client.dart';
import '../services/api_urls.dart';

class MarkLeaveProvider extends ChangeNotifier {
  final _apiClient = ApiClient();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  final dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  final timeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));

  final locationController = TextEditingController();
  final notesController = TextEditingController();

  String selectedLeaveType = 'Sick';

  void onLeaveTypeSelected(String leaveType) {
    selectedLeaveType = leaveType;
    notifyListeners();
  }

  Widget buildLeaveTypeOption(String leaveType) {
    bool isSelected = leaveType == selectedLeaveType;
    return GestureDetector(
      onTap: () => onLeaveTypeSelected(leaveType),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            leaveType,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Future<(bool, String)> markLeave(String date, String time, String location,
      String reason, String leaveType) async {
    setLoading(true);
    try {
      Response response = await _apiClient.post(ApiUrls.markLeaveUrl, data: {
        "date": date,
        "time": time,
        "reason": reason,
        "leaveType": '$leaveType Leave',
        "location": location
      });
      setLoading(false);
      if (response.statusCode == 200) {
        return (true, response.data['message'].toString());
      } else {
        return (false, response.data['message'].toString());
      }
    } on DioException catch (e) {
      setLoading(false);
      if (e.response != null && e.response?.data != null) {
        // Extracting the error message from the Dio response
        return (false, e.response!.data['message'].toString());
      } else {
        // When no response or response data is available
        return (false, 'Something went wrong');
      }
    } catch (e) {
      setLoading(false);
      return (false, 'Something want wrong');
    }
  }
}
