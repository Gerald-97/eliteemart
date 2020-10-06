class Product {
  String total;
  int page;
  int totalPages;
  List<ProductElement> products;

  Product({
    this.total,
    this.page,
    this.totalPages,
    this.products,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    total: json["total"],
    page: json["page"],
    totalPages: json["totalPages"],
    products: List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "totalPages": totalPages,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class ProductElement {
  int id;
  String slug;
  String productName;
  String productPrice;
  String productAvatar;
  int productCategory;
  int productSubCategory;
  int productQuantity;

  ProductElement({
    this.id,
    this.slug,
    this.productName,
    this.productPrice,
    this.productAvatar,
    this.productCategory,
    this.productSubCategory,
    this.productQuantity,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    id: json["id"],
    slug: json["slug"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productAvatar: json["product_avatar"],
    productCategory: json["product_category"],
    productSubCategory: json["product_sub_category"],
    productQuantity: json["product_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "product_name": productName,
    "product_price": productPrice,
    "product_avatar": productAvatar,
    "product_category": productCategory,
    "product_sub_category": productSubCategory,
    "product_quantity": productQuantity,
  };
}