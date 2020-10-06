class CartGet {
  int id;
  int userId;
  int productId;
  String productAvatar;
  String productName;
  String productPrice;
  int quantity;
  String totalCost;

  CartGet({
    this.id,
    this.userId,
    this.productId,
    this.productAvatar,
    this.productName,
    this.productPrice,
    this.quantity,
    this.totalCost,
  });

  factory CartGet.fromJson(Map<String, dynamic> json) => CartGet(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        productAvatar: json["product_avatar"] == null
            ? 'https://selvatour.pl/wp-content/uploads/adventure-tours-assets/placeholder-194x220.png'
            : json["product_avatar"],
        productName: json["product_name"],
        productPrice: json["product_price"],
        quantity: json["quantity"],
        totalCost: json["total_cost"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "product_avatar": productAvatar == null
            ? 'https://selvatour.pl/wp-content/uploads/adventure-tours-assets/placeholder-194x220.png'
            : productAvatar,
        "product_name": productName,
        "product_price": productPrice,
        "quantity": quantity,
        "total_cost": totalCost,
      };

  @override
  String toString() {
    return 'Datum{id: $id, userId: $userId, productId: $productId, productName: $productName, productPrice: $productPrice, quantity: $quantity, totalCost: $totalCost}';
  }
}
