import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  int id;
  String nameCategory;

  Category({
    required this.id,
    required this.nameCategory,
  });
  
  Category.empty() : id = 0, nameCategory = '';


 factory Category.fromJson(Map<String, dynamic> json) => Category(
  id: int.parse(json["id"].toString()), 
  nameCategory: json["name_category"] ?? 'Nombre por defecto', 
);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_category": nameCategory,
      };
}