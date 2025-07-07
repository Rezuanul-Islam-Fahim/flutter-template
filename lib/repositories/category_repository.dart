import 'package:dio/dio.dart';

import '../models/category.dart';

class CategoryRepository {
  final Dio dio = Dio();

  Future<List<Category>> getCategories() async {
    Response response = await dio.get(
      'https://sea-lion-app-59x7b.ondigitalocean.app/kal/category',
    );
    List<dynamic> categoryList = response.data;

    return List.generate(
      categoryList.length,
      (int index) =>
          Category.fromJson(categoryList[index] as Map<String, dynamic>),
    );
  }
}
