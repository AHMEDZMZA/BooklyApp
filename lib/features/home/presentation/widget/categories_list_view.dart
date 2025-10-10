import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/resoures/app_colors.dart';
import '../../data/repo/home_repo_imple.dart';
import '../../manager/cubit/get_book_cubit.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              GetBookCubit(HomeRepoImple(apiService: ApiService(dio: Dio())))
                ..fetchBook(),
      child: BlocBuilder<GetBookCubit, GetBookState>(
        builder: (context, state) {
          if (state is GetBookSuccess) {
            return SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 224,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(

                      onTap: () {
                        final similarBooks = state.books.where((book) {
                          final currentCategory = state.books[index].volumeInfo?.categories?.first;
                          final bookCategory = book.volumeInfo?.categories?.first;

                          return bookCategory == currentCategory &&
                              book.id != state.books[index].id;
                        }).toList();


                        Navigator.pushNamed(
                          context,
                          '/BookDetailsView',
                          arguments: {
                            'book': state.books[index],
                            'books': similarBooks,
                          },
                        );
                        if (similarBooks.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No similar books found.',
                                style: TextStyle(
                                  color: AppColors.secondColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                            ),
                          );
                          return;
                        }

                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        width: index == 0 ? 170 : 150,
                        //height: 224,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                              state
                                  .books[index]
                                  .volumeInfo!
                                  .imageLinks!
                                  .thumbnail!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is GetBookFailure) {
            return SliverToBoxAdapter(
              child: Center(child: Text(state.errorMassage)),
            );
          } else {
            return SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 224,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Shimmer(
                      duration: const Duration(seconds: 2),
                      color: Colors.grey.shade300,
                      colorOpacity: 0.4,
                      child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        width: index == 0 ? 170 : 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
