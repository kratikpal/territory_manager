class ProductManualModel {
  final ProductManualDetail productManualDetail;
  final String id;
  final String title;
  final String createdAt;
  final String updatedAt;
  final int version;

  ProductManualModel({
    required this.productManualDetail,
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory ProductManualModel.fromJson(Map<String, dynamic> json) {
    return ProductManualModel(
      productManualDetail: ProductManualDetail.fromJson(json['product_manual']),
      id: json['_id'],
      title: json['title'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'],
    );
  }
}

class ProductManualDetail {
  final String publicId;
  final String url;
  final String filename;

  ProductManualDetail({
    required this.publicId,
    required this.url,
    required this.filename,
  });

  factory ProductManualDetail.fromJson(Map<String, dynamic> json) {
    return ProductManualDetail(
      publicId: json['public_id'],
      url: json['url'],
      filename: json['filename'],
    );
  }
}
