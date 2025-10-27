import 'package:books/features/home/data/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resoures/app_images.dart';
import '../../../../../core/routing/routes.dart';

class SliversAppBar extends StatelessWidget {
  const SliversAppBar({super.key, required this.books});

  final List<BookModel> books;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,

      /// لو عندك قائمة طويلة، الـ AppBar هيفضل ثابت فوق ومش هيتحرك.
      snap: false,

      /// لو snap: true ➜ الـ AppBar “ينط” أو “يظهر فجأة” بشكل سلس لما المستخدم يبدأ سحب خفيف لأعلى.
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.grey,
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                AppImages.logoImage,
                height: 30.h,
                width: 75.w,
                fit: BoxFit.fill,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.searchView, arguments: books);
                },
                icon: const Icon(Icons.search_rounded, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
