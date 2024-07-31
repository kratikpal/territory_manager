import 'package:cheminova/models/user_model.dart';
import 'package:cheminova/services/api_client.dart';
import 'package:cheminova/services/api_urls.dart';
import 'package:cheminova/services/secure__storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final _apiClient = ApiClient();

  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> fetchUserProfile() async {
    setLoading(true);
    try {
      Response response = await _apiClient.get(
        ApiUrls.profileUrl,
      );
      setLoading(false);
      if (response.statusCode == 200) {
        final data = response.data['myData'];
        await SecureStorageService().write(key: 'user', value: data.toString());
        _user = UserModel.fromJson(data);

        notifyListeners();
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      setLoading(false);
      throw Exception('Failed to load user profile: $e');
    }
  }

  Future<void> clearUserProfile() async {
    _user = null;
    notifyListeners();
  }
}
