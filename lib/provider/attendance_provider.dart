import 'package:cheminova/services/api_client.dart';
import 'package:cheminova/services/api_urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AttendanceProvider extends ChangeNotifier {
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
