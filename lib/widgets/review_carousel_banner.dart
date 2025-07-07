import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/review.dart';

class ReviewCarouselBanner extends StatefulWidget {
  const ReviewCarouselBanner({super.key, required this.review});

  final Review review;

  @override
  State<ReviewCarouselBanner> createState() => _ReviewCarouselBannerState();
}

class _ReviewCarouselBannerState extends State<ReviewCarouselBanner> {
  int bannerItemIndex = 0;

  void _onBannerChanged(int index, _) {
    setState(() {
      bannerItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              initialPage: 0,
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.3,
              enableInfiniteScroll: false,
              reverse: false,
              onPageChanged: _onBannerChanged,
              scrollDirection: Axis.horizontal,
            ),
            items: widget.review.imgUrls!.map((String url) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Image.network(
                  url,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
          ),
        ),
        Positioned(
          bottom: 10,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.review.imgUrls!.length,
                (int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: bannerItemIndex == index
                          ? Colors.white
                          : Colors.white38,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
