import 'package:books/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../../core/resoures/app_styels.dart';
import '../../../data/repo/home_repo_imple.dart';
import '../../../manager/cubit/get_book_cubit.dart';

class BestSellerSliverLists extends StatelessWidget {
  const BestSellerSliverLists({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              GetBookCubit(getIt.get<HomeRepoImple>())..fetchFreeBook(),
      child: BlocBuilder<GetBookCubit, GetBookState>(
        builder: (context, state) {
          if (state is GetBookSuccess) {
            return SliverList.builder(
              itemCount: state.books.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 20.w,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80.w,
                        height: 110.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
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
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.books[index].volumeInfo?.title ??
                                  "No Title Available",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.textStyle20Bold,
                            ),

                            SizedBox(height: 5.h),
                            Text(
                              "${state.books[index].volumeInfo?.authors ?? 'Unknown Author'}",
                              style: AppStyles.textStyle14W400,
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " Price : ${state.books[index].saleInfo?.listPrice?.amount.toString() ?? "Free"} ",
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 15.sp,
                                    ),
                                    SizedBox(width: 2.w),
                                    Text("4.8"),
                                    SizedBox(width: 4.w),
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
              },
            );
          } else if (state is GetBookFailure) {
            return SliverToBoxAdapter(
              child: Center(child: Text(state.errorMassage)),
            );
          }
          return SliverList.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Shimmer(
                  child: Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
