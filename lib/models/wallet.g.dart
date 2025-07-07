// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      id: json['id'] as int?,
      publicKey: json['public_key'] as String?,
      signature:
          (json['signature'] as List<dynamic>?)?.map((e) => e as int).toList(),
      message:
          (json['message'] as List<dynamic>?)?.map((e) => e as int).toList(),
      networkId: json['network_id'] as int?,
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'id': instance.id,
      'public_key': instance.publicKey,
      'signature': instance.signature,
      'message': instance.message,
      'network_id': instance.networkId,
    };
