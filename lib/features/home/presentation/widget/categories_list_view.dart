import 'package:books/features/home/presentation/cubit/get_book_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_service.dart';
import '../../data/repo/home_repo_imple.dart';

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
                        Navigator.pushNamed(
                          context,
                          '/BookDetailsView',
                          arguments: {
                            'book': state.books[index],
                            'books': state.books,
                          },
                        );
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
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
