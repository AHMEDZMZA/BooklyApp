import 'package:books/core/routing/app_router.dart';
import 'package:books/core/routing/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/service_locator.dart';
import 'core/resoures/app_colors.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(357, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        onGenerateRoute: appRouter.generateRouter,
        initialRoute: Routes.splashView,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.primaryColor,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
