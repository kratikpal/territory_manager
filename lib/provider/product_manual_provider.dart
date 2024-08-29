import 'package:cheminova/models/product_manual_model.dart';
import 'package:cheminova/services/api_urls.dart';
import 'package:cheminova/services/api_client.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductManualProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<ProductManualModel> _productManualList = [];
  final _apiClient = ApiClient();

  List<ProductManualModel> get productManualList => _productManualList;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> getProductManualList() async {
    setLoading(true);
    try {
      Response response = await _apiClient.get(ApiUrls.getProductsManual);

      if (response.statusCode == 200) {
        List<ProductManualModel> data =
            (response.data['productManuals'] as List)
                .map((json) => ProductManualModel.fromJson(json))
                .toList();
        _productManualList = data;
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      setLoading(false);
    }
  }
}
