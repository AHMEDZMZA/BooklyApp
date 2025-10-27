import 'package:books/core/routing/routes.dart';
import 'package:books/features/home/presentation/view/book_details_view.dart';
import 'package:books/features/home/presentation/view/home_view.dart';
import 'package:books/features/home/presentation/view/search_view.dart';
import 'package:flutter/material.dart';
import '../../features/home/data/model/book_model.dart';
import '../../features/splash/presentation/view/splash_view.dart';

class AppRouter {
  Route<dynamic>? generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case Routes.homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case Routes.bookDetailsView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BookDetailsView(),
          settings: RouteSettings(arguments: args),
        );

      case Routes.searchView:
        final args = settings.arguments as List<BookModel>;
        return MaterialPageRoute(
          builder: (_) => const SearchView(),
          settings: RouteSettings(arguments: args),
        );

      default:
        return null;
    }
  }
}
