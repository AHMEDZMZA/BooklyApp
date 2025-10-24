import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/model/book_model.dart';

class ReadBookOnline extends StatelessWidget {
  const ReadBookOnline({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse(book.volumeInfo!.previewLink ?? "No Link");
    Future<void> _launchUrl() async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _launchUrl,
          child: Center(
            child: Container(
              width: 290.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Center(
                child: Text(
                  "Read Book Online",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
