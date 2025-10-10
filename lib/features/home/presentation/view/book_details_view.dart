import 'package:books/core/resoures/app_styels.dart';
import 'package:flutter/material.dart';
import '../../data/model/book_model.dart';
import '../widget/book_details_expanded_widget.dart';
import '../widget/row_check_pdf_and_read_online.dart';

class BookDetailsView extends StatelessWidget {
  const BookDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final BookModel book = args['book'];
    final List<BookModel> books = args['books'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 180,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
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
              const SizedBox(height: 25),
              Center(
                child: Text(
                  book.volumeInfo?.title ?? "No Title",
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  "${book.volumeInfo?.authors ?? "Unknown Author"}",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  const SizedBox(width: 5),
                  Text("4.8"),
                  const SizedBox(width: 10),
                  Text("(${book.volumeInfo?.pageCount ?? 0} reviews)"),
                ],
              ),
              const SizedBox(height: 15),
              BookDetailsExpandedWidget(book: book),
              const SizedBox(height: 15),
              RowCheckPdfAndReadOnline(book: book),
              const SizedBox(height: 20),
              Text('You can also like', style: AppStyles.textStyle20Bold),
              const SizedBox(height: 10),
              SizedBox(
                height: 224,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 15),
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
