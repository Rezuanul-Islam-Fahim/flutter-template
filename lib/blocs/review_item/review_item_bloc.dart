import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/review.dart';
import '../../models/category.dart' as cat;
import '../../repositories/reviews_repository.dart';

part 'review_item_event.dart';
part 'review_item_state.dart';

class ReviewItemBloc extends Bloc<ReviewItemEvent, ReviewItemState> {
  ReviewItemBloc() : super(ReviewItemLoading()) {
    on<ReviewItemLoad>(_onStarted);
  }

  Future<void> _onStarted(
    ReviewItemLoad event,
    Emitter<ReviewItemState> emit,
  ) async {
    final ReviewsRepository repository = ReviewsRepository();
    emit(ReviewItemLoading());

    try {
      final Review review = await repository.loadReviewById(
        id: event.id,
        category: event.category,
        agree: event.agree,
        imgUrls: event.imgUrls,
        authorImg: event.authorImg,
      );
      emit(ReviewItemLoaded(review: review));
    } catch (_) {
      emit(ReviewItemError());
    }
  }
}
