import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/notification_list_response.dart';
import '../services/api_client.dart';
import '../services/api_urls.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider() {
    getNotification();
  }

  final _apiClient = ApiClient();
  List<Notifications> notificationList = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> getNotification() async {
    setLoading(true);
    try {
    Response response = await _apiClient.get(ApiUrls.notificationUrl);
    setLoading(false);
    if (response.statusCode == 200) {
      final data = NotificationListResponse.fromJson(response.data);
      notificationList = data.notifications ?? [];
      notifyListeners();
    }
    } catch (e) {
      setLoading(false);
    }
  }
}
