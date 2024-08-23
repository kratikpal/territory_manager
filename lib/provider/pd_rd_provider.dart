import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cheminova/models/pd_rd_response_model.dart';
import 'package:cheminova/services/api_client.dart';
import 'package:cheminova/services/api_urls.dart';

class PdRdProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<PdRdResponseModel> _pdList = [];
  List<PdRdResponseModel> get pdList => _pdList;
  List<PdRdResponseModel> _rdList = [];
  List<PdRdResponseModel> get rdList => _rdList;

  final _apiClient = ApiClient();

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearLists() {
    _pdList.clear();
    _rdList.clear();
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
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      setLoading(false);
    }
  }
}
