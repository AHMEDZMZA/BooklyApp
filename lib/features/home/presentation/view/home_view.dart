import 'package:books/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resoures/app_styels.dart';
import '../../data/repo/home_repo_imple.dart';
import '../../manager/cubit/get_book_cubit.dart';
import '../widget/home_widgets/best_seller_sliver_lists.dart';
import '../widget/home_widgets/categories_list_view.dart';
import '../widget/home_widgets/slivers_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => GetBookCubit(getIt.get<HomeRepoImple>())..fetchBook(),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<GetBookCubit, GetBookState>(
            builder: (context, state) {
              if (state is GetBookSuccess) {
                return CustomScrollView(
                  slivers: [
                    /// AppBar
                    SliversAppBar(books: state.books),
                    SliverToBoxAdapter(child: SizedBox(height: 20.h)),

                    /// Categories
                    const CategoriesListView(index: 0),
                    SliverToBoxAdapter(child: SizedBox(height: 20.h)),

                    /// Best Seller
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: Text(
                          "Best Seller",
                          style: AppStyles.textStyle18BoldWhite,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 10.h)),

                    /// Best Seller List
                    const BestSellerSliverLists(),
                  ],
                );
              }
              if (state is GetBookFailure) {
                return Center(
                  child: Text(
                    state.errorMassage,
                    style: AppStyles.textStyle16W400,
                  ),
                );
              }
              return Center(
                child: Text("Please wait...", style: AppStyles.textStyle16W400),
              );
            },
          ),
        ),
      ),
    );
  }
}
