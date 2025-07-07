import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../models/review.dart';
import '../repositories/reviews_repository.dart';
import 'comment_box.dart';

class LocationReviews extends StatefulWidget {
  const LocationReviews({
    super.key,
    required this.locationId,
    required this.review,
  });

  final int locationId;
  final Review review;

  @override
  State<LocationReviews> createState() => _LocationReviewsState();
}

class _LocationReviewsState extends State<LocationReviews> {
  final List<String> _tabs = [
    'Comments',
    'Similiar reviews',
    'Add your reviews',
  ];
  int _currentIndex = 0;

  void changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget getBody(int index, List<Review> reviews) {
    if (index == 0) {
      return _buildComments(reviews);
    } else if (index == 1) {
      _buildSimiliarReviews(reviews);
    }

    return _buildOwnReviews(reviews);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ReviewsRepository repository = ReviewsRepository();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(
            _tabs.length,
            (int index) {
              return GestureDetector(
                onTap: () => changeIndex(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  color:
                      index == _currentIndex ? Colors.white : Colors.grey[100],
                  child: Center(
                    child: Text(
                      _tabs[index],
                      style: index != _currentIndex
                          ? theme.textTheme.titleSmall
                          : theme.textTheme.titleSmall!.copyWith(
                              color: AppTheme.primaryColor,
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        FutureBuilder(
          future: repository.getReviewsByLocation(
            locationId: widget.locationId,
            reviewRemove: widget.review,
          ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                      strokeWidth: 3,
                    ),
                  ),
                ),
              );
            }
            List<Review> reviews = snapshot.data;

            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
              child: getBody(_currentIndex, reviews),
            );
          },
        ),
      ],
    );
  }

  Widget _buildComments(List<Review> reviews) {
    return Column(
      children: reviews.map((Review review) {
        return CommentBox(review: review);
      }).toList(),
    );
  }

  Widget _buildSimiliarReviews(List<Review> reviews) {
    return Column(
      children: reviews.map((Review review) {
        return CommentBox(review: review);
      }).toList(),
    );
  }

  Widget _buildOwnReviews(List<Review> reviews) {
    return Column(
      children: reviews.map((Review review) {
        return CommentBox(review: review);
      }).toList(),
    );
  }
}
