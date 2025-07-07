// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as int?,
      stars: json['stars'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      walletId: json['wallet_id'] as int?,
      agree: json['agree'] as int?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      imgUrls: (json['img_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      kalLocationId: json['kal_location_id'] as int?,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'stars': instance.stars,
      'description': instance.description,
      'title': instance.title,
      'created_at': instance.createdAt,
      'kal_location_id': instance.kalLocationId,
      'wallet_id': instance.walletId,
      'categories': instance.categories,
      'img_urls': instance.imgUrls,
      'agree': instance.agree,
      'location': instance.location,
      'wallet': instance.wallet,
    };
