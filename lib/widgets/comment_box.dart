import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/review.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({
    super.key,
    required this.review,
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.description!,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      review.authorImg!,
                      width: 40,
                      height: 40,
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
                        DateFormat.yMMMMEEEEd().format(
                          DateTime.parse(review.createdAt!),
                        ),
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.thumb_down),
                    iconSize: 16,
                    color: Colors.grey[500],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.thumb_up),
                    iconSize: 16,
                    color: Colors.grey[500],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
