part of 'review_item_bloc.dart';

@immutable
abstract class ReviewItemEvent extends Equatable {
  const ReviewItemEvent();
}

class ReviewItemLoad extends ReviewItemEvent {
  const ReviewItemLoad({
    required this.id,
    required this.category,
    required this.agree,
    required this.imgUrls,
    required this.authorImg,
  });

  final int id;
  final cat.Category category;
  final int agree;
  final List<String> imgUrls;
  final String authorImg;

  @override
  List<Object> get props => [id, category, agree, imgUrls, authorImg];
}
