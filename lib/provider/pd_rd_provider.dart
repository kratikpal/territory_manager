import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cheminova/models/pd_rd_response_model.dart';
import 'package:cheminova/services/api_client.dart';
import 'package:cheminova/services/api_urls.dart';

class PdRdProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<PdRdResponseModel> _pdRdList = [];
  List<PdRdResponseModel> get pdRdList => _pdRdList;

  final _apiClient = ApiClient();

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> getPdRd() async {
    setLoading(true);
    try {
      Response response = await _apiClient.get(ApiUrls.getPdRdUrl);
      if (response.statusCode == 200) {
        // Assuming the response data is a list of PdRdResponseModel objects
        List<PdRdResponseModel> data = (response.data as List)
            .map((json) => PdRdResponseModel.fromJson(json))
            .toList();
        _pdRdList = data;
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
