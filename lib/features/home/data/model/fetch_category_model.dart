import 'package:growmind_tutuor/features/home/domain/entities/fetch_model.dart';

class CategoryModel extends Category {
  CategoryModel({required super.id, required super.name});

  factory CategoryModel.fromFirestore(Map<String, dynamic> json, String id) {
    return CategoryModel(id: id, name: json['category']);
  }
}

class SubCategoryModel extends Subcategory {
  SubCategoryModel({required super.name});
  factory SubCategoryModel.fromFirestore(Map<String, dynamic> json) {
    return SubCategoryModel(name: json['name']);
  }
}
