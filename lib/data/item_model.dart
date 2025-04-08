import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/data/category_model.dart';
part 'item_model.g.dart';

@HiveType(typeId: 1)
class ItemModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  CategoryModel? category;
  @HiveField(3)
  String location;
  @HiveField(4)
  String status;
  @HiveField(5)
  Uint8List image;
  ItemModel({
    required this.name,
    required this.description,
    required this.category,
    required this.location,
    required this.status,
    required this.image,
  });
}
