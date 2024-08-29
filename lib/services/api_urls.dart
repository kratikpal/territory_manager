class ApiUrls {
  static const String baseUrl = 'https://cheminova-api-2.onrender.com/api/';
  static const String loginUrl = 'territorymanager/login';
  static const String profileUrl = 'territorymanager/my-profile';
  static const String markAttendanceUrl = 'v1/markattendance/territorymanager';
  static const String markLeaveUrl = 'v1/markleave/territorymanager';
  static const String forgetPasswordUrl = 'territorymanager/forgot-password';
  static const String changePasswordUrl = 'territorymanager/password/update';
  static const String createCollectKycUrl = '${baseUrl}kyc/create-tm';
  static const String getPdUrl = 'kyc/get-pd-tm';
  static const String rejectedApplication = '${baseUrl}kyc/getAllrejected-tm';
  static const String notificationUrl = '$baseUrl/get-notification-tm';
  static const String fcmUrl = '${baseUrl}kyc/save-fcm-tm';
  static const String getProducts = '${baseUrl}product/getAll/user/';
  static const String getRd = 'inventory/distributors-TM/RetailDistributor';
  static const String getPd = 'inventory/distributors-TM/PrincipalDistributor';
  static const String submitProducts = 'inventory/add-TM';
  static const String getSalesCoordinators = 'salescoordinator/getAll-TM';
  static const String assignTask = 'task/assign-task';
  static const String getProductsManual = 'productmanual/getall';
}
