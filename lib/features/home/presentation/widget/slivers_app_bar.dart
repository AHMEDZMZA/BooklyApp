import 'package:books/features/home/data/model/book_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/resoures/app_images.dart';

class SliversAppBar extends StatelessWidget {
  const SliversAppBar({super.key, required this.books});
  final List<BookModel> books ;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      snap: false,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.grey,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                AppImages.logoImage,
                height: 30,
                width: 75,
                filterQuality: FilterQuality.low,
                fit: BoxFit.fill,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/SearchView',arguments: books);
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
