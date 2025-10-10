import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/model/book_model.dart';

class RowCheckPdfAndReadOnline extends StatelessWidget {
  const RowCheckPdfAndReadOnline({super.key, required this.book});

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
          onTap: () {
            final isAvailable = book.accessInfo?.pdf?.isAvailable ?? false;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isAvailable
                      ? ' PDF version is available for this book!'
                      : ' No PDF version available for this book.',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                backgroundColor: isAvailable ? Colors.green : Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Center(
            child: Container(
              width: 160,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  "Check Book pdf",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: _launchUrl,
          child: Center(
            child: Container(
              width: 160,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "Read Book Online",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
