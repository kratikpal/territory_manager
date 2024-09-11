class PdRdResponseModel {
  String? id;
  String? uniqueId;
  String? name;
  ShippingAddress? shippingAddress;
  Kyc? kyc;

  String? salesCoordinator; // Nullable property for SalesCoordinator

  PdRdResponseModel({
    this.id,
    this.uniqueId,
    this.name,
    this.kyc,
    this.shippingAddress,
    this.salesCoordinator, // Initialize SalesCoordinator
  });

  factory PdRdResponseModel.fromJson(Map<String, dynamic> json) =>
      PdRdResponseModel(
        id: json["_id"],
        name: json["name"],
        uniqueId: json["uniqueId"],
        kyc: json["kyc"] != null ? Kyc.fromJson(json["kyc"]) : null,
        shippingAddress: json['shippingAddress'] != null
            ? ShippingAddress.fromJson(json['shippingAddress'])
            : null,
        salesCoordinator: json.containsKey('salesCoordinator')
            ? json['salesCoordinator']
            : null, // Handle missing field
      );
}

class ShippingAddress {
  final String id;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String panNumber;
  final String tradeName;
  final String gstNumber;
  final bool isDefault;

  ShippingAddress({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.panNumber,
    required this.tradeName,
    required this.gstNumber,
    required this.isDefault,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      id: json['_id'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      country: json['country'] ?? '',
      panNumber: json['panNumber'] ?? '',
      tradeName: json['tradeName'] ?? '',
      gstNumber: json['gstNumber'] ?? '',
      isDefault: json['isDefault'] ?? false,
    );
  }
}

class Kyc {
  final String id;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String panNumber;
  final String tradeName;
  final String gstNumber;
  final bool isDefault;
  final String? panImgUrl; // New field for PAN image URL
  final String? aadharImgUrl; // New field for Aadhar image URL
  final String? gstImgUrl; // New field for GST image URL

  Kyc({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.panNumber,
    required this.tradeName,
    required this.gstNumber,
    required this.isDefault,
    this.panImgUrl,
    this.aadharImgUrl,
    this.gstImgUrl,
  });

  factory Kyc.fromJson(Map<String, dynamic> json) {
    return Kyc(
      id: json['_id'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      country: json['country'] ?? '',
      panNumber: json['panNumber'] ?? '',
      tradeName: json['trade_name'] ?? '',
      gstNumber: json['gstNumber'] ?? '',
      isDefault: json['isDefault'] ?? false,
      panImgUrl: json['pan_img']?['url'],
      aadharImgUrl: json['aadhar_img']?['url'],
      gstImgUrl: json['gst_img']?['url'],
    );
  }
}
