class SalesTaskResponse {
  bool? success;
  int? totalData;
  int? totalPages;
  List<SalesProduct>? products;

  SalesTaskResponse(
      {this.success, this.totalData, this.totalPages, this.products});

  SalesTaskResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalData = json['total_data'];
    totalPages = json['total_pages'];
    if (json['products'] != null) {
      products = <SalesProduct>[];
      json['products'].forEach((v) {
        products!.add(SalesProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['total_data'] = totalData;
    data['total_pages'] = totalPages;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesProduct {
  String? sId;
  String? SKU;
  String? ProductName;
  Category? category;
  Brand? brand;
  int? price;
  int? gST;
  int? hSNCode;
  String? description;
  String? productStatus;
  AddedBy? addedBy;
  List<Null>? image;
  String? createdAt;
  String? updatedAt;
  int? SalesAmount;
  int? QuantitySold;
  String? comments;
  int? iV;

  SalesProduct(
      {this.sId,
      this.SKU,
      this.ProductName,
      this.category,
      this.brand,
      this.price,
      this.gST,
      this.hSNCode,
      this.description,
      this.productStatus,
      this.addedBy,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.QuantitySold,
      this.comments,
      this.SalesAmount,
      this.iV});

  SalesProduct.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    SKU = json['SKU'];
    ProductName = json['name'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    price = json['price'];
    gST = json['GST'];
    hSNCode = json['HSN_Code'];
    description = json['description'];
    productStatus = json['product_Status'];
    addedBy =
        json['addedBy'] != null ? AddedBy.fromJson(json['addedBy']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['SKU'] = SKU;
    data['name'] = ProductName;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    data['price'] = price;
    data['GST'] = gST;
    data['HSN_Code'] = hSNCode;
    data['description'] = description;
    data['product_Status'] = productStatus;
    if (addedBy != null) {
      data['addedBy'] = addedBy!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Category {
  String? sId;
  String? categoryName;

  Category({this.sId, this.categoryName});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryName'] = categoryName;
    return data;
  }
}

class Brand {
  String? sId;
  String? brandName;

  Brand({this.sId, this.brandName});

  Brand.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    brandName = json['brandName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['brandName'] = brandName;
    return data;
  }
}

class AddedBy {
  String? sId;
  String? name;

  AddedBy({this.sId, this.name});

  AddedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}
