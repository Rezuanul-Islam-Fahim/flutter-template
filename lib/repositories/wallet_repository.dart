import 'package:bs58/bs58.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/wallet.dart';

class WalletRepository {
  final Dio dio = Dio();

  Future<Wallet> getWallet(Map<String, dynamic> data) async {
    String url = 'https://sea-lion-app-59x7b.ondigitalocean.app/wallet';
    Wallet newWallet = Wallet(
      id: 0,
      networkId: 1,
      publicKey: data['publicKey'],
      signature: base58.decode(data['signature']),
      message: data['message'],
    );
    late Response response;

    try {
      response = await dio.post(
        url,
        data: newWallet.toJson(),
      );
    } catch (_) {}

    return Wallet(
      id: response.data['id'],
      networkId: response.data['network_id'],
      publicKey: response.data['public_key'],
      signature: base58.decode(data['signature']),
      message: data['message'],
    );
  }

  Future<Wallet?> getWalletById({required int id}) async {
    try {
      String url = 'https://sea-lion-app-59x7b.ondigitalocean.app/wallet/$id';
      Response response = await dio.get(url);

      return Wallet.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print('Error in wallet repository');
        print(e.toString());
      }
    }

    return null;
  }
}
