import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/location.dart';
import '../models/wallet.dart';

class LocationRepository {
  final Dio dio = Dio();

  Future<Location?> getLocation({required int id}) async {
    try {
      Response response = await dio.get(
        'https://sea-lion-app-59x7b.ondigitalocean.app/kal/location/$id',
      );

      return Location.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print('Error in location repository');
        print(e.toString());
      }
    }

    return null;
  }

  Future<Location?> addLocation({
    required String lat,
    required String lng,
    required Wallet wallet,
  }) async {
    Location? location;

    try {
      Response response = await dio.post(
        'https://sea-lion-app-59x7b.ondigitalocean.app/kal/location',
        data: {
          "geometry": {"lat": lat, "lng": lng},
          "wallet_request": {
            "id": wallet.id,
            "message": wallet.message,
            "network_id": wallet.networkId,
            "public_key": wallet.publicKey,
            "signature": wallet.signature,
          }
        },
      );

      location = Location.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred');
        print(e.toString());
      }
    }

    return location;
  }
}
