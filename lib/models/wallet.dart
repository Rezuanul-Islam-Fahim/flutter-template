import 'package:json_annotation/json_annotation.dart';

part 'wallet.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Wallet {
  int? id;
  String? publicKey;
  List<int>? signature;
  List<int>? message;
  int? networkId;

  Wallet({
    this.id,
    this.publicKey,
    this.signature,
    this.message,
    this.networkId,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
