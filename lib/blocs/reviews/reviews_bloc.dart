import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/category.dart' as cat;
import '../../models/review.dart';
import '../../repositories/category_repository.dart';
import '../../repositories/reviews_repository.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  ReviewsBloc() : super(ReviewsLoading()) {
    on<ReviewsStarted>(_onStarted);
  }

  Future<void> _onStarted(
    ReviewsStarted event,
    Emitter<ReviewsState> emit,
  ) async {
    final CategoryRepository categoryRepository = CategoryRepository();
    final ReviewsRepository reviewsRepository = ReviewsRepository();
    emit(ReviewsLoading());

    try {
      final List<cat.Category> categories =
          await categoryRepository.getCategories();
      final List<Review> reviews = await reviewsRepository.getReviews(
        categories: categories,
      );
      emit(ReviewsLoaded(reviews: reviews, categories: categories));
    } catch (_) {
      emit(ReviewsError());
    }
  }
}
