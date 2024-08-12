import 'package:cheminova/notification_service.dart';
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
        final fcmToken = await NotificationServices().getDeviceToken();
        print('fcmToken: $fcmToken');
        await _apiClient.post(ApiUrls.fcmUrl, data: {'fcmToken': fcmToken});
        return (true, response.data['message'].toString());
      } else {
        return (false, response.data['message'].toString());
      }
    } catch (e) {
      setLoading(false);
      return (false, 'Something want wrong');
    }
  }
}
