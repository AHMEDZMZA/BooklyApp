import 'package:books/features/home/data/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<BookModel>;

    final searchBooks =
        args.where((book) {
          final currentBook = book.volumeInfo?.title ?? '';
          final searchText = searchController.text.trim().toLowerCase();
          return currentBook.toLowerCase().contains(searchText);
        }).toList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Search Books',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for a book...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child:
                      searchBooks.isEmpty
                          ? Center(
                            child: Text(
                              'No books found',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            ),
                          )
                          : ListView.builder(
                            padding: EdgeInsets.all(10.w),
                            itemCount: searchBooks.length,
                            itemBuilder: (context, index) {
                              final book = searchBooks[index];
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 4.w,
                                ),
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade900,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.network(
                                        book
                                                .volumeInfo
                                                ?.imageLinks
                                                ?.thumbnail ??
                                            '',
                                        width: 60.w,
                                        height: 90.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        book.volumeInfo?.title ??
                                            'Unknown title',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
