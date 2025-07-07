// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      id: json['id'] as int?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      createdAt: json['created_at'] as String?,
      googlePlaceId: json['google_place_id'] as String?,
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'created_at': instance.createdAt,
      'google_place_id': instance.googlePlaceId,
      'lat': instance.lat,
      'lng': instance.lng,
    };
