import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Category {
  const Category({
    this.id,
    this.name,
    this.createdAt,
    this.kalLocationId,
  });

  final int? id;
  final String? name;
  final String? createdAt;
  final int? kalLocationId;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
