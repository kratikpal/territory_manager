import 'package:cheminova/services/api_client.dart';
import 'package:cheminova/services/api_urls.dart';
import 'package:cheminova/services/secure__storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AttendanceProvider extends ChangeNotifier {
  final _storageService = SecureStorageService();

  final _apiClient = ApiClient();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<(bool, String)> markAttendance(
      String date, String time, String location, String notes) async {
    setLoading(true);
    try {
      Response response = await _apiClient.post(ApiUrls.markAttendanceUrl,
          data: {
            'date': date,
            'time': time,
            'location': location,
            'notes': notes
          });
      setLoading(false);
      if (response.statusCode == 200) {
        return (true, response.data['message'].toString());
      } else {
        return (false, response.data['message'].toString());
      }
    } catch (e) {
      setLoading(false);
      return (false, 'Something want wrong');
    }
  }
}
