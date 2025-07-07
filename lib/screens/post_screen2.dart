import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../models/location.dart';
import '../utils/navigator.dart';
import '../widgets/form_info.dart';
import 'post_screen3.dart';

class PostScreen2 extends StatefulWidget {
  const PostScreen2({super.key});

  static const String route = '/post2';

  @override
  State<PostScreen2> createState() => _PostScreen2State();
}

class _PostScreen2State extends State<PostScreen2> {
  final List<String> _reviewTexts = [
    'Too Bad',
    'Bad',
    'Average',
    'Good',
    'Awesome',
  ];
  String _experience = '';
  String _overallReview = '';
  int _rating = -1;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Location location =
        ModalRoute.of(context)!.settings.arguments! as Location;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormInfo(
                  title: 'So my experience with',
                  inputHintText: location.name!,
                  enabled: false,
                  hintColor: AppTheme.primaryColor,
                ),
                const SizedBox(height: 15),
                Text('is...', style: theme.textTheme.titleLarge),
                const SizedBox(height: 15),
                Row(
                  children: List.generate(
                    _reviewTexts.length,
                    (int index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _rating = index;
                              });
                            },
                            child: Icon(
                              Icons.star,
                              size: 50,
                              color: _rating < index
                                  ? Colors.grey[400]
                                  : Colors.amber,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _reviewTexts[index],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),
                FormInfo(
                  title: 'Describe your review',
                  inputHintText: 'Enter your experience',
                  onChanged: (String value) {
                    _experience = value;
                  },
                ),
                const SizedBox(height: 25),
                FormInfo(
                  title: 'So overall it is a...',
                  inputHintText: 'Give it a title',
                  onChanged: (String value) {
                    _overallReview = value;
                  },
                ),
                const SizedBox(height: 75),
              ],
            ),
          ),
        ),
        bottomSheet: GestureDetector(
          onTap: () {
            Nav.to(
              context,
              PostScreen3.route,
              arguments: [
                location,
                _overallReview,
                _experience,
                _rating,
              ],
            );
          },
          child: Container(
            height: 60,
            width: double.infinity,
            color: AppTheme.primaryColor,
            child: Center(
              child: Text(
                'Continue',
                style: theme.textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
