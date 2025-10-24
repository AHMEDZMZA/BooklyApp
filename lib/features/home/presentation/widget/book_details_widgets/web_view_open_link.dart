import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../data/model/book_model.dart';

class WebViewOpenLink extends StatelessWidget {
  const WebViewOpenLink({super.key, required this.book});

  final BookModel book;

  // دالة لتحويل أي رابط http إلى https تلقائيًا
  String getSafeUrl(String? url) {
    if (url == null || url.isEmpty) return "https://flutter.dev";
    if (url.startsWith("http://")) {
      return url.replaceFirst("http://", "https://");
    }
    return url;
  }

  void showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blueGrey.shade800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String safeUrl = getSafeUrl(book.volumeInfo!.previewLink);

    late final controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {},
              onPageStarted: (String url) {
                showSnack(context, "Loading page...");
              },
              onPageFinished: (String url) {
                showSnack(context, "Page loaded successfully");
              },
              onHttpError: (HttpResponseError error) {
                showSnack(context, "HTTP Error occurred");
              },
              onWebResourceError: (WebResourceError error) {
                showSnack(context, "Web Resource Error: ${error.description}");
              },
              onNavigationRequest: (NavigationRequest request) {
                if (request.url.startsWith('')) {
                  showSnack(context, "Blocked YouTube link");
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(safeUrl));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Book On App'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
