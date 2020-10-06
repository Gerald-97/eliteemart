class SubCategory {
  String total;
  int page;
  int totalPages;
  List<Subcategory> subcategories;

  SubCategory({
    this.total,
    this.page,
    this.totalPages,
    this.subcategories,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    total: json["total"],
    page: json["page"],
    totalPages: json["totalPages"],
    subcategories: List<Subcategory>.from(json["Subcategories"].map((x) => Subcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "totalPages": totalPages,
    "Subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'SubCategory{total: $total, page: $page, totalPages: $totalPages, subcategories: $subcategories}';
  }
}

class Subcategory {
  int id;
  int categoryId;
  String subCategoryName;

  Subcategory({
    this.id,
    this.categoryId,
    this.subCategoryName,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["id"],
    categoryId: json["category_id"],
    subCategoryName: json["sub_category_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "sub_category_name": subCategoryName,
  };

  @override
  String toString() {
    return 'Subcategory{id: $id, categoryId: $categoryId, subCategoryName: $subCategoryName}';
  }


}