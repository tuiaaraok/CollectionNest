import 'package:hive_flutter/hive_flutter.dart';

part 'category_model.g.dart';

@HiveType(typeId: 2)
class CategoryModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String svgPath;
  CategoryModel({required this.svgPath, required this.name});
}
