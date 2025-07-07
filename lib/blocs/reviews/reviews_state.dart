part of 'reviews_bloc.dart';

@immutable
abstract class ReviewsState extends Equatable {
  const ReviewsState();
}

class ReviewsLoading extends ReviewsState {
  @override
  List<Object> get props => [];
}

class ReviewsLoaded extends ReviewsState {
  const ReviewsLoaded({this.reviews, this.categories});

  final List<cat.Category>? categories;
  final List<Review>? reviews;

  @override
  List<Object> get props => [...reviews!, categories!];
}

class ReviewsError extends ReviewsState {
  @override
  List<Object> get props => [];
}
