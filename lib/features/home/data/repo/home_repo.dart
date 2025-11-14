import 'package:books/features/home/data/model/book_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/error_massage.dart';

abstract class HomeRepo {
  Future<Either<ErrorMassage, List<BookModel>>> fetchAllBook();

  Future<Either<ErrorMassage, List<BookModel>>> fetchFreeAllBook();
}
