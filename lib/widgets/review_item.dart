import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../models/category.dart';
import '../models/review.dart';
import '../screens/location_details_screen.dart';
import '../utils/navigator.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.currentCategory,
    required this.review,
  });

  final Category currentCategory;
  final Review review;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Nav.to(
          context,
          LocationDetailScreen.route,
          arguments: [review, currentCategory],
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.location!.name!,
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    currentCategory.name!,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    review.title!,
                    style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildRating(review.stars!),
                      Text(
                        '${review.agree}% agreed',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(
                        'Posted by ${review.wallet!.publicKey!.substring(0, 6)}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                review.imgUrls![0],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRating(int rating) {
    return Row(
      children: List.generate(5, (int index) {
        return Icon(
          Icons.star,
          size: 10,
          color: index + 1 > rating ? Colors.amber[200] : Colors.amber,
        );
      }),
    );
  }
}
