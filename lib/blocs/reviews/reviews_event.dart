part of 'reviews_bloc.dart';

@immutable
abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();
}

class ReviewsStarted extends ReviewsEvent {
  @override
  List<Object> get props => [];
}
