import 'package:flutter/material.dart';
import '../../../../core/resoures/app_styels.dart';
import '../widget/best_seller_sliver_lists.dart';
import '../widget/categories_list_view.dart';
import '../widget/slivers_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// AppBar
            const SliversAppBar(),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            /// Categories
            const CategoriesListView(),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            /// Best Seller
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Best Seller", style: AppStyles.textStyle18Bold),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            /// Best Seller List
            const BestSellerSliverLists(),
          ],
        ),
      ),
    );
  }
}
