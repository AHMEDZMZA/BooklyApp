import 'package:flutter/material.dart';
import 'core/resoures/app_colors.dart';
import 'features/home/presentation/view/book_details_view.dart';
import 'features/home/presentation/view/home_view.dart';
import 'features/splash/presentation/splash/view/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/HomeView': (context) => HomeView(),
        '/BookDetailsView': (context) => BookDetailsView(),
      },
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.primaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
