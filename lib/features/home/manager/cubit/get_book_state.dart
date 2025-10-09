part of 'get_book_cubit.dart';

@immutable
sealed class GetBookState {}

final class GetBookInitial extends GetBookState {}

final class GetBookLoading extends GetBookState {}

final class GetBookSuccess extends GetBookState {
  final List<BookModel> books;

  GetBookSuccess({required this.books});
}

final class GetBookFailure extends GetBookState {
  final String errorMassage;

  GetBookFailure({required this.errorMassage});
}
