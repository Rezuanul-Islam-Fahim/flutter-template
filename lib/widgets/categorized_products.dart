import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/review.dart';
import 'review_item.dart';

class CategorizedProducts extends StatelessWidget {
  const CategorizedProducts({
    super.key,
    required this.category,
    required this.reviews,
  });

  final Category category;
  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    final List<Review> categorizedReviews = reviews
        .where((Review review) => review.categories!.contains(category.name))
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: categorizedReviews.map((Review review) {
              return ReviewItem(
                currentCategory: category,
                review: review,
              );
            }).toList(),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
