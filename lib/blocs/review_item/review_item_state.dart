part of 'review_item_bloc.dart';

@immutable
abstract class ReviewItemState extends Equatable {
  const ReviewItemState();
}

class ReviewItemLoading extends ReviewItemState {
  @override
  List<Object> get props => [];
}

class ReviewItemLoaded extends ReviewItemState {
  const ReviewItemLoaded({this.review});

  final Review? review;

  @override
  List<Object> get props => [review!];
}

class ReviewItemError extends ReviewItemState {
  @override
  List<Object> get props => [];
}
