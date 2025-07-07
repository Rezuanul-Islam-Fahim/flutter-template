import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/review_item/review_item_bloc.dart';
import '../core/app_theme.dart';
import '../models/category.dart';
import '../models/review.dart';
import '../widgets/review_carousel_banner.dart';
import '../widgets/location_reviews.dart';

class LocationDetailScreen extends StatelessWidget {
  const LocationDetailScreen({super.key});

  static const String route = '/location-detail';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final List<dynamic> data =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final Review review = data[0];
    final Category category = data[1];

    return BlocProvider(
      create: (_) => ReviewItemBloc()
        ..add(
          ReviewItemLoad(
            id: review.id!,
            category: category,
            agree: review.agree!,
            imgUrls: review.imgUrls!,
            authorImg: review.authorImg!,
          ),
        ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<ReviewItemBloc, ReviewItemState>(
            builder: (BuildContext context, ReviewItemState state) {
              if (state is ReviewItemLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                );
              }

              if (state is ReviewItemLoaded) {
                Review review = state.review!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: mediaQuery.size.width,
                      height:
                          (mediaQuery.size.height - mediaQuery.padding.top) *
                              0.3,
                      child: Stack(
                        children: [
                          ReviewCarouselBanner(review: review),
                          Positioned(
                            top: 15,
                            left: 10,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height:
                          (mediaQuery.size.height - mediaQuery.padding.top) *
                              0.7,
                      child: ListView(
                        padding: const EdgeInsets.only(top: 0, bottom: 40),
                        children: [
                          _buildProductOverview(review, theme),
                          Divider(
                            height: 0,
                            thickness: 8,
                            color: Colors.grey.shade100,
                          ),
                          LocationReviews(
                            locationId: review.location!.id!,
                            review: review,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return const Text('Something is not right');
            },
          ),
          bottomSheet: SizedBox(
            height: 50,
            child: Row(
              children: [
                _buildProductInfo(
                  color: Colors.blue,
                  icon: Icons.comment,
                  title: 'Comment',
                  data: '120 comments',
                ),
                _buildProductInfo(
                  color: Colors.red,
                  icon: Icons.thumb_down,
                  title: 'Not agree',
                  data: '110 Not Agreed',
                ),
                _buildProductInfo(
                  color: Colors.green,
                  icon: Icons.thumb_up,
                  title: 'Agree',
                  data: '90 agreed',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductOverview(Review review, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.location!.name!,
            style: theme.textTheme.titleMedium!.copyWith(
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            review.categories![0],
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 8),
          Text(
            review.title!,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            review.description!,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRatings(review),
              Text(
                '${review.agree}% agreed',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                ),
              ),
              Text(
                DateFormat.yMMMMEEEEd().format(
                  DateTime.parse(review.createdAt!),
                ),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildAuthorDetails(review, theme),
        ],
      ),
    );
  }

  Widget _buildRatings(Review review) {
    return Row(
      children: List.generate(
        5,
        (int index) {
          return Icon(
            Icons.star,
            size: 18,
            color: index + 1 > review.stars! ? Colors.amber[200] : Colors.amber,
          );
        },
      ),
    );
  }

  Widget _buildAuthorDetails(Review review, ThemeData theme) {
    return Row(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                review.authorImg!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.wallet!.publicKey!.substring(0, 8),
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 3),
                Text(
                  'View profile',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.primaryColor),
            ),
            child: Text(
              'Follow',
              style: theme.textTheme.titleSmall!.copyWith(
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo({
    required Color color,
    required IconData icon,
    required String title,
    required String data,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          color: color,
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.white, size: 13),
              const SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    data,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
