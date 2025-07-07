import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/location.dart';
import '../models/review.dart';
import '../models/wallet.dart';
import '../models/category.dart' as cat;
import 'location_repository.dart';
import 'wallet_repository.dart';

List<String> imageUrls = [
  'https://www.gizmochina.com/wp-content/uploads/2019/05/oneplus_7_pro--500x500.jpg',
  'https://www.mobiledokan.com/wp-content/uploads/2019/05/OnePlus-7-Pro.jpg',
  'https://abcglassprocessing.co.uk/wp-content/uploads/2021/08/Square-glass-table-top-AdobeStock_177724729.jpg',
  'https://www.discountdecor.co.za/wp-content/uploads/2016/05/Ghost-Glass-Coffee-Table.jpg',
  'https://img.freepik.com/free-photo/bouquet-roses-vase-with-copy-space_23-2148822250.jpg?w=740&t=st=1666623869~exp=1666624469~hmac=89f353120b1619b241a804901094ffae51c47af188d341f01f4d9c49b1d02a8a',
  'https://media-cdn.tripadvisor.com/media/photo-s/13/08/1a/b4/getlstd-property-photo.jpg',
  'https://media-cdn.tripadvisor.com/media/photo-s/10/67/33/0e/photo1jpg.jpg',
];

List<String> authorImages = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYIjBqDgKWLjNl63Q8o0cG2FYEblNx_wStMA&usqp=CAU',
  'https://www.arweave.net/J7i1FCgnlp7FXC7M0Mg-_MbYk_J0DGPbd0Rw03gt69I?ext=jpeg',
  'https://airnfts.s3.amazonaws.com/nft-images/20211017/Casual_crypto_punk_1634504656783.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYIjBqDgKWLjNl63Q8o0cG2FYEblNx_wStMA&usqp=CAU',
  'https://i1.sndcdn.com/avatars-rfwy5mSeUytFz5Gx-8s06ZQ-t500x500.jpg',
];

class ReviewsRepository {
  final Dio dio = Dio();
  final LocationRepository locationRepository = LocationRepository();
  final WalletRepository walletRepository = WalletRepository();

  Future<List<Review>> getReviews({
    required List<cat.Category> categories,
  }) async {
    List<Review> reviewsList = [];

    try {
      Response response = await dio.get(
        'https://sea-lion-app-59x7b.ondigitalocean.app/kal/review',
      );
      List<dynamic> responseData = response.data;

      reviewsList = List.generate(
        responseData.length,
        (int index) =>
            Review.fromJson(responseData[index] as Map<String, dynamic>),
      );

      for (Review review in reviewsList) {
        Location? location = await locationRepository.getLocation(
          id: review.kalLocationId!,
        );
        Wallet? wallet = await walletRepository.getWalletById(
          id: review.walletId!,
        );
        review.location = location;
        review.wallet = wallet;
        review.agree = math.Random().nextInt(50) + 50;

        imageUrls.shuffle();
        review.imgUrls = imageUrls
            .getRange(0, math.Random().nextInt(imageUrls.length) + 1)
            .toList();
        authorImages.shuffle();
        review.authorImg =
            authorImages[math.Random().nextInt(authorImages.length)];

        List<cat.Category> filteredCategories = categories
            .where((cat.Category elem) =>
                elem.kalLocationId == review.kalLocationId)
            .toList();
        review.categories =
            filteredCategories.map((cat.Category elem) => elem.name!).toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Something happenned');
        print(e.toString());
      }
    }

    return reviewsList;
  }

  Future<Review> loadReviewById({
    required int id,
    required cat.Category category,
    required int agree,
    required List<String> imgUrls,
    required String authorImg,
  }) async {
    late Review review;

    try {
      Response response = await dio.get(
        'https://sea-lion-app-59x7b.ondigitalocean.app/kal/review/$id',
      );
      review = Review.fromJson(response.data as Map<String, dynamic>);

      Location? location = await locationRepository.getLocation(
        id: review.kalLocationId!,
      );
      Wallet? wallet = await walletRepository.getWalletById(
        id: review.walletId!,
      );
      review.location = location;
      review.wallet = wallet;
      review.agree = agree;
      review.imgUrls = imgUrls;
      review.categories = [category.name!];
      review.authorImg = authorImg;
    } catch (e) {
      if (kDebugMode) {
        print('Something happenned');
        print(e.toString());
      }
    }

    return review;
  }

  Future<List<Review>> getReviewsByLocation({
    required int locationId,
    required Review reviewRemove,
  }) async {
    List<Review> reviewsList = [];

    try {
      Response response = await dio.get(
        'https://sea-lion-app-59x7b.ondigitalocean.app/kal/review',
      );
      List<dynamic> responseData = response.data;

      reviewsList = List.generate(
        responseData.length,
        (int index) =>
            Review.fromJson(responseData[index] as Map<String, dynamic>),
      );
      reviewsList = reviewsList
          .where((Review elem) => elem.kalLocationId == locationId)
          .toList();
      reviewsList = reviewsList
          .where((Review elem) => elem.id != reviewRemove.id)
          .toList();

      for (Review review in reviewsList) {
        Wallet? wallet = await walletRepository.getWalletById(
          id: review.walletId!,
        );
        review.wallet = wallet;

        authorImages.shuffle();
        review.authorImg =
            authorImages[math.Random().nextInt(authorImages.length)];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Something happenned');
        print(e.toString());
      }
    }

    return reviewsList;
  }

  Future<void> postReview({
    required String title,
    required String description,
    required int stars,
    required int locationId,
    required Wallet wallet,
  }) async {
    try {
      await dio.post(
        'https://sea-lion-app-59x7b.ondigitalocean.app/kal/review',
        data: {
          "review": {
            "created_at": DateTime.now().toIso8601String(),
            "description": description,
            "kal_location_id": locationId,
            "stars": stars,
            "title": title,
            "wallet_id": wallet.id,
          },
          "wallet_request": {
            "id": wallet.id,
            "message": wallet.message,
            "network_id": wallet.networkId,
            "public_key": wallet.publicKey,
            "signature": wallet.signature,
          },
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred');
        print(e.toString());
      }
    }
  }
}
