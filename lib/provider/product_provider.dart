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
  final List<Product> _selectedProducts = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Product> get selectedProducts => _selectedProducts;

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
        productList = productResponse!.products;
        notifyListeners();
      }
    } catch (e) {
      setLoading(false);
      print("Error: $e");
    }
  }

  Future<bool> submitSelectedProducts(
      String addedFor, String addedForId) async {
    setLoading(true);
    try {
      final data = {
        "products": selectedProducts.map((product) {
          return {
            "SKU": product.SKU,
            "ProductName": product.name,
            "Sale": product.sale,
            "Inventory": product.inventory,
          };
        }).toList(),
        "addedFor": addedFor,
        "addedForId": addedForId,
      };

      Response response =
          await _apiClient.post(ApiUrls.submitProducts, data: data);
      setLoading(false);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      setLoading(false);
      print("Error: $e");
      return false;
    }
  }
}
