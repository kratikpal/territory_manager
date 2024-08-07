import 'package:cheminova/models/rejected_applicaton_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/api_client.dart';
import '../services/api_urls.dart';

class RejectedProvider extends ChangeNotifier {
  RejectedProvider() {
    getRejectedApplication();
  }
  final _apiClient = ApiClient();
  RejectedApplicationResponse? rejectedApplicationResponse;
  List<RejectedApplicationResponse> rejectedApplicationList = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> getRejectedApplication() async {
    setLoading(true);
    try {
      Response response = await _apiClient.get(ApiUrls.rejectedApplication);
      setLoading(false);
      if (response.statusCode == 200) {
        rejectedApplicationList = (response.data as List)
            .map((e) => RejectedApplicationResponse.fromJson(e))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      setLoading(false);
    }
  }
}
