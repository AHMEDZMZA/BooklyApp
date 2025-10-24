import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/service_locator.dart';
import 'core/resoures/app_colors.dart';
import 'features/home/presentation/view/book_details_view.dart';
import 'features/home/presentation/view/home_view.dart';
import 'features/home/presentation/view/search_view.dart';
import 'features/splash/presentation/view/splash_view.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(357, 812),
      //designSize: const Size(1440, 3120),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        routes: {
          '/HomeView': (context) => HomeView(),
          '/BookDetailsView': (context) => BookDetailsView(),
          '/SearchView': (context) => SearchView(),
        },
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashView(),
      ),
    );
  }
}
