import 'package:cheminova/screens/data_submit_successfull.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../services/api_client.dart';
import '../services/api_urls.dart';

class VisitPdRdProvider with ChangeNotifier {
  final _apiClient = ApiClient();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> submitVisitPdRd(BuildContext context, String id) async {
    setLoading(true);
    try {
      Response response =
          await _apiClient.put(ApiUrls.updateTaskInventoryUrl + id);
      debugPrint('Response: $response');
      setLoading(false);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DataSubmitSuccessfull()));
      }
    } catch (e) {
      setLoading(false);
      debugPrint("Error: $e");
    }
  }
}
