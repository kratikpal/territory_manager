import 'package:cheminova/models/product_model.dart';
import 'package:cheminova/services/api_client.dart';
import 'package:cheminova/services/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider() {
    getProducts();
  }

  final _apiClient = ApiClient();
  ProductResponse? productResponse;
  List<Product> productList = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> getProducts() async {
    setLoading(true);
    try {
      Response response = await _apiClient.get(ApiUrls.getProducts);
      setLoading(false);
      if (response.statusCode == 200) {
        productResponse = ProductResponse.fromJson(response.data);
        productList = productResponse!.product;
        notifyListeners();
      }
    } catch (e) {
      setLoading(false);
      print("Error: $e");
    }
  }
}
