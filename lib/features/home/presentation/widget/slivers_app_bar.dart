import 'package:flutter/material.dart';
import '../../../../core/resoures/app_images.dart';

class SliversAppBar extends StatelessWidget {
  const SliversAppBar({super.key});

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
                onPressed: () {},
                icon: const Icon(Icons.search_rounded, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
