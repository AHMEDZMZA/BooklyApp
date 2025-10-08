import 'package:books/features/home/presentation/cubit/get_book_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/resoures/app_styels.dart';
import '../../data/repo/home_repo_imple.dart';

class BestSellerSliverLists extends StatelessWidget {
  const BestSellerSliverLists({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              GetBookCubit(HomeRepoImple(apiService: ApiService(dio: Dio())))
                ..fetchFreeBook(),
      child: BlocBuilder<GetBookCubit, GetBookState>(
        builder: (context, state) {
          if (state is GetBookSuccess) {
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                              state
                                  .books[index]
                                  .volumeInfo!
                                  .imageLinks!
                                  .smallThumbnail!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.books[index].volumeInfo?.title ??
                                  "No Title Available",
                              style: AppStyles.textStyle20Bold,
                            ),

                            const SizedBox(height: 5),
                            Text(
                              (state.books[index].volumeInfo?.authors?.join(
                                    ', ',
                                  ) ??
                                  'Unknown Author'),
                              style: AppStyles.textStyle14W400,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " Price : ${state.books[index].saleInfo?.listPrice?.amount.toString() ?? "No Price Available"} ",
                                ),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 15,
                                    ),
                                    SizedBox(width: 2),
                                    Text("4.8"),
                                    SizedBox(width: 4),
                                    Text("(2390)"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: state.books.length),
            );
          } else if (state is GetBookFailure) {
            return SliverToBoxAdapter(child: Text(state.errorMassage));
          }
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
