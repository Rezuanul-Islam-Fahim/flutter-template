import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Location {
  const Location({
    this.id,
    this.name,
    this.address,
    this.createdAt,
    this.googlePlaceId,
    this.lat,
    this.lng,
  });

  final int? id;
  final String? name;
  final String? address;
  final String? createdAt;
  final String? googlePlaceId;
  final String? lat;
  final String? lng;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
