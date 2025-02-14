class ProductResponse {
  final bool success;
  final int totalData;
  final int totalPages;
  final List<Product> products;

  ProductResponse({
    required this.success,
    required this.totalData,
    required this.totalPages,
    required this.products,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      success: json['success'],
      totalData: json['total_data'],
      totalPages: json['total_pages'],
      products: (json['products'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'total_data': totalData,
      'total_pages': totalPages,
      'products': products.map((item) => item.toJson()).toList(),
    };
  }
}

class Product {
  final String id;
  final String SKU;
  final String name;
  final Category category;
  final Brand brand;
  final double price;
  final int GST;
  final int HSNCode;
  final String description;
  final String productStatus;
  final AddedBy addedBy;
  final List<dynamic> image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  int? sale;
  int? inventory;

  Product({
    required this.id,
    required this.SKU,
    required this.name,
    required this.category,
    required this.brand,
    required this.price,
    required this.GST,
    required this.HSNCode,
    required this.description,
    required this.productStatus,
    required this.addedBy,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.sale,
    this.inventory,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      SKU: json['SKU'],
      name: json['name'],
      category: Category.fromJson(json['category']),
      brand: Brand.fromJson(json['brand']),
      price: (json['price'] as num).toDouble(),
      GST: json['GST'],
      HSNCode: json['HSN_Code'],
      description: json['description'] ?? '',
      productStatus: json['product_Status'],
      addedBy: AddedBy.fromJson(json['addedBy']),
      image: json['image'] as List<dynamic>,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      sale: json['sale'], // Nullable field
      inventory: json['inventory'], // Nullable field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'SKU': SKU,
      'name': name,
      'category': category.toJson(),
      'brand': brand.toJson(),
      'price': price,
      'GST': GST,
      'HSN_Code': HSNCode,
      'description': description,
      'product_Status': productStatus,
      'addedBy': addedBy.toJson(),
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'sale': sale, // Nullable field
      'inventory': inventory, // Nullable field
    };
  }
}

class Category {
  final String id;
  final String categoryName;

  Category({
    required this.id,
    required this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      categoryName: json['categoryName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'categoryName': categoryName,
    };
  }
}

class Brand {
  final String id;
  final String brandName;

  Brand({
    required this.id,
    required this.brandName,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['_id'],
      brandName: json['brandName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'brandName': brandName,
    };
  }
}

class AddedBy {
  final String id;
  final String name;

  AddedBy({
    required this.id,
    required this.name,
  });

  factory AddedBy.fromJson(Map<String, dynamic> json) {
    return AddedBy(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
