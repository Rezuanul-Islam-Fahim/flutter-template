import 'package:json_annotation/json_annotation.dart';

import 'location.dart';
import 'wallet.dart';

part 'review.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Review {
  Review({
    this.id,
    this.stars,
    this.title,
    this.description,
    this.createdAt,
    this.walletId,
    this.agree,
    this.categories,
    this.imgUrls,
    this.kalLocationId,
    this.authorImg,
    this.location,
    this.wallet,
  });

  final int? id;
  final int? stars;
  final String? description;
  final String? title;
  final String? createdAt;
  final int? kalLocationId;
  final int? walletId;
  String? authorImg;
  List<String>? categories;
  List<String>? imgUrls;
  int? agree;
  Location? location;
  Wallet? wallet;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
