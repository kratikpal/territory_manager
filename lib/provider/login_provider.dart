import 'package:cheminova/services/api_client.dart';
import 'package:cheminova/services/api_urls.dart';
import 'package:cheminova/services/secure__storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final _storageService = SecureStorageService();

  final _apiClient = ApiClient();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<(bool, String)> login() async {
    setLoading(true);
    try {
      Response response = await _apiClient.post(ApiUrls.loginUrl, data: {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim()
      });
      setLoading(false);
      if (response.statusCode == 200) {
        await _storageService.write(
            key: 'access_token', value: response.data['token']);
        return (true, response.data['message'].toString());
      } else {
        return (false, response.data['message'].toString());
      }
    } on DioException catch (e) {
      setLoading(false);

      if (e.response?.data is Map<String, dynamic>) {
        return (
          false,
          e.response?.data['message'].toString() ?? 'something went wrong'
        );
      } else if (e.response?.data is String) {
        return (false, e.response?.data.toString() ?? 'something went wrong');
      } else {
        return (false, 'something went wrong');
      }
    } catch (e) {
      setLoading(false);
      return (false, 'something went wrong');
    }
  }
}
