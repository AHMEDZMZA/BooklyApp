import 'package:flutter/material.dart';
import '../../../../core/resoures/app_images.dart';
import '../../../../core/resoures/app_styels.dart';

class BestSellerSliverLists extends StatelessWidget {
  const BestSellerSliverLists({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(AppImages.imageBook),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Harry Potter\n and the Goblet of Fire",
                      style: AppStyles.textStyle20Bold,
                    ),
                    const SizedBox(height: 5),
                    Text("J.K. Rowling", style: AppStyles.textStyle14W400),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("19.99 €"),
                        Row(
                          children: const [
                            Icon(Icons.star, color: Colors.amber, size: 15),
                            SizedBox(width: 2),
                            Text("4.5"),
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
      },
    );
  }
}
