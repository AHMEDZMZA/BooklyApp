import 'package:books/core/error_massage.dart';
import 'package:books/core/network/api_service.dart';
import 'package:books/features/home/data/model/book_model.dart';
import 'package:books/features/home/data/repo/home_repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImple implements HomeRepo {
  final ApiService apiService;

  HomeRepoImple({required this.apiService});

  @override
  Future<Either<ErrorMassage, List<BookModel>>> fetchAllBook() async {
    try {
      var data = await apiService.get(endPoint: "volumes?Filtering=free-ebooks&q=programming");
      List<BookModel> books = [];
      for (var item in data["items"]) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } catch (e) {
      return left(ErrorMassage(errorMassage: e.toString()));
    }
  }

  @override
  Future<Either<ErrorMassage, List<BookModel>>> fetchFreeAllBook() async {
    try {
      var data = await apiService.get(
        endPoint: "volumes?Filtering=free-ebooks&Sorting=newest&q=programming",
      );
      List<BookModel> books = [];
      for (var item in data["items"]) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } catch (e) {
      return left(ErrorMassage(errorMassage: e.toString()));
    }
  }
}
