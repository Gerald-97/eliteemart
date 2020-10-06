
class CartItem {
  int productId;
  int quantity;

  CartItem({
    this.productId,
    this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    productId: json["product_id"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "quantity": quantity,
  };
}