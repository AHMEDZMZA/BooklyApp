import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/resoures/app_styels.dart';
import '../../data/repo/home_repo_imple.dart';
import '../../manager/cubit/get_book_cubit.dart';
import '../widget/best_seller_sliver_lists.dart';
import '../widget/categories_list_view.dart';
import '../widget/slivers_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              GetBookCubit(HomeRepoImple(apiService: ApiService(dio: Dio())))
                ..fetchBook(),
      child: Scaffold(
        body: BlocBuilder<GetBookCubit, GetBookState>(
          builder: (context, state) {
            if (state is GetBookSuccess) {
              return SafeArea(
                child: CustomScrollView(
                  slivers: [
                    /// AppBar
                    SliversAppBar(books: state.books),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),

                    /// Categories
                    const CategoriesListView(index: 0),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),

                    /// Best Seller
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "Best Seller",
                          style: AppStyles.textStyle18BoldWhite,
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 20)),

                    /// Best Seller List
                    const BestSellerSliverLists(),
                  ],
                ),
              );
            }
            return Center(
              child: Text("Please wait...", style: AppStyles.textStyle16W400),
            );
          },
        ),
      ),
    );
  }
}

/*
BlocProvider(
      create: (context) => GetBookCubit(
        HomeRepoImple(apiService: ApiService(dio: Dio())),
      )..fetchBook(),
      child:
 */
