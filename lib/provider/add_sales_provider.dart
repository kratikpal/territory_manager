import 'dart:convert';

import 'package:cheminova/constants/constant.dart';
import 'package:cheminova/models/sales_task_response.dart';
import 'package:cheminova/screens/data_submit_successfull.dart';
import 'package:cheminova/services/api_client.dart';
import 'package:cheminova/services/api_urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddSalesProvider with ChangeNotifier {
  final _apiClient = ApiClient();
  List<SalesProduct> tasksList = [];
  List<SalesProduct> searchList = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<SalesProduct> selectedProducts = [];

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> getTask() async {
    setLoading(true);
    try {
      Response response = await _apiClient.get(ApiUrls.salesTaskUrl);
      setLoading(false);
      if (response.statusCode == 200) {
        final data = SalesTaskResponse.fromJson(response.data);
        tasksList = data.products ?? [];
        notifyListeners();
      }
    } catch (e) {
      setLoading(false);
      debugPrint("Error occurred while fetching sales tasks: $e");
    }
  }

  void filterProducts(String val) {
    tasksList = tasksList.where((element) {
      final productNameLower = element.ProductName!.toLowerCase();
      final productSkuLower = element.SKU!.toLowerCase();
      final searchLower = val.toLowerCase();
      return productNameLower.contains(searchLower) ||
          productSkuLower.contains(searchLower);
    }).toList();
    notifyListeners();
  }

  Future<void> submitProducts(
      {required String distributorType,
      required String pdRdId,
      required String date,
      String? inventoryId,
      required String tradeName}) async {
    setLoading(true);
    try {
      Response response = await _apiClient.post(ApiUrls.postSalesTaskUrl,
          data: json.encode({
            "addedFor": distributorType.replaceAll(' ', ''),
            "addedForId": pdRdId,
            "tradename": tradeName,
            "date": date,

            "products": selectedProducts.map((product) {
              return {
                "SKU": product.SKU,
                "ProductName": product.ProductName,
                "QuantitySold": product.QuantitySold,
                "comments": product.comments,
                "SalesAmount": product.SalesAmount
              };
            }).toList()
           // "products": selectedProducts.map((e) => e.toJson()).toList()
          }));
      setLoading(false);
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(
          navigatorKey.currentContext!,
        ).showSnackBar(
          SnackBar(content: Text(response.data['message'])),
        );
        if (inventoryId != null) {
          _apiClient
              .put(ApiUrls.updateTaskInventoryUrl + inventoryId, data: null)
              .then((value) {
            debugPrint('Task Updated');
            if (value.statusCode == 200) {
              resetProducts();
              Navigator.push(
                  navigatorKey.currentContext!,
                  MaterialPageRoute(
                      builder: (context) =>
                          const DataSubmitSuccessfull()));
            } else {
              ScaffoldMessenger.of(
                navigatorKey.currentContext!,
              ).showSnackBar(
                const SnackBar(content: Text('Task not updated')),
              );
            }
          });
        } else {
          resetProducts();
          Navigator.push(
              navigatorKey.currentContext!,
              MaterialPageRoute(
                  builder: (context) => const DataSubmitSuccessfull()));
        }
      }
    } catch (e) {
      setLoading(false);
      debugPrint("Error: $e");
    }
  }

  void resetProducts() {
    selectedProducts.clear();
    tasksList.clear();
    notifyListeners();
  }
}