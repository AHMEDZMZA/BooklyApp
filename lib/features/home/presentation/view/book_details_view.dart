import 'package:books/core/resoures/app_styels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/book_model.dart';
import '../widget/book_details_widgets/book_details_expanded_widget.dart';
import '../widget/book_details_widgets/read_book_online.dart';
import '../widget/book_details_widgets/web_view_open_link.dart';

class BookDetailsView extends StatelessWidget {
  const BookDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final BookModel book = args['book'];
    final List<BookModel> books = args['books'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.h,
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 180.w,
                    height: 250.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      image: DecorationImage(
                        image: NetworkImage(
                          book.volumeInfo?.imageLinks?.thumbnail ??
                              " No Book Similar ",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                Center(
                  child: Text(
                    book.volumeInfo?.title ?? "No Title",
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Center(
                  child: Text(
                    "${book.volumeInfo?.authors ?? "Unknown Author"}",
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18.sp),
                    SizedBox(width: 5.w),
                    Text("4.8"),
                    SizedBox(width: 10.w),
                    Text("(${book.volumeInfo?.pageCount ?? 0} reviews)"),
                  ],
                ),
                SizedBox(height: 15.h),
                BookDetailsExpandedWidget(book: book),
                SizedBox(height: 15.h),
                ReadBookOnline(book: book),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewOpenLink(book: book),
                      ),
                    );
                  },
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Text(
                          "Read Book On App",
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
                SizedBox(height: 20.h),
                Text('You can also like', style: AppStyles.textStyle20Bold),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 224.h,
                  child: books.isEmpty
                      ? Center(
                    child: Text(
                      'No books similar',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  )
                      : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 15.r),
                        width: 150.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          image: DecorationImage(
                            image: NetworkImage(
                              books[index].volumeInfo!.imageLinks!.thumbnail!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
