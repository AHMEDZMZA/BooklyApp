import 'package:flutter/material.dart';
import '../../../../core/resoures/app_colors.dart';
import '../../../../core/resoures/app_styels.dart';
import '../../data/model/book_model.dart';

class BookDetailsExpandedWidget extends StatelessWidget {
  const BookDetailsExpandedWidget({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              child: Text(
                book.saleInfo?.retailPrice?.amount != null
                    ? "${book.saleInfo?.retailPrice?.amount}€"
                    : "Free",
                style: AppStyles.textStyle18Bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 48,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: AppColors.secondColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              child: Text(
                "Free preview",
                style: AppStyles.textStyle18BoldWhite,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
