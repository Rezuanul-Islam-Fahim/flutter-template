import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/reviews/reviews_bloc.dart';
import '../core/app_theme.dart';
import '../models/category.dart' as cat;
import '../utils/navigator.dart';
import '../widgets/app_icon.dart';
import '../widgets/categorized_products.dart';
import '../widgets/main_drawer.dart';
import 'post_screen1.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  static const String route = '/list';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsBloc, ReviewsState>(
      builder: (BuildContext context, ReviewsState state) {
        if (state is ReviewsLoading) {
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          );
        }

        if (state is ReviewsLoaded) {
          return DefaultTabController(
            length: state.categories!.length,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const AppIcon(),
                  bottom: PreferredSize(
                    preferredSize: const Size(double.infinity, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSearchField(),
                        _buildTabBar(state.categories!),
                      ],
                    ),
                  ),
                ),
                drawer: const MainDrawer(),
                body: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TabBarView(
                    children: List.generate(
                      state.categories!.length,
                      (int index) {
                        return CategorizedProducts(
                          category: state.categories![index],
                          reviews: state.reviews!,
                        );
                      },
                    ),
                  ),
                ),
                bottomSheet: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: 85,
                  padding: const EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: () => Nav.to(context, PostScreen1.route),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.5),
                            offset: const Offset(0, 10),
                            blurRadius: 8,
                            spreadRadius: -3,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'Add New Review',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        if (kDebugMode) {
          print('Unknown error occurred');
        }
        return Container();
      },
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintText: 'Search Product or brand',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildTabBar(List<cat.Category> categories) {
    return SizedBox(
      height: 35,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          unselectedLabelColor: Colors.grey[600],
          labelColor: AppTheme.primaryColor,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide.none,
          ),
          labelPadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          enableFeedback: true,
          isScrollable: true,
          tabs: categories.map((cat.Category cat) {
            return Tab(child: Text(cat.name!));
          }).toList(),
        ),
      ),
    );
  }
}
