import 'package:books/features/home/data/model/book_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/home_repo.dart';

part 'get_book_state.dart';

class GetBookCubit extends Cubit<GetBookState> {
  final HomeRepo homeRepo;

  GetBookCubit(this.homeRepo) : super(GetBookInitial());

  void fetchBook() async {
    emit(GetBookLoading());
    var result = await homeRepo.fetchAllBook();
    result.fold(
      (error) => emit(GetBookFailure(errorMassage: error.errorMassage)),
      (books) => emit(GetBookSuccess(books: books)),
    );
  }

  void fetchFreeBook() async {
    emit(GetBookLoading());
    var result = await homeRepo.fetchFreeAllBook();
    result.fold(
      (error) => emit(GetBookFailure(errorMassage: error.errorMassage)),
      (books) => emit(GetBookSuccess(books: books)),
    );
  }
}
