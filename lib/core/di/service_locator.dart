import 'package:books/core/network/api_service.dart';
import 'package:books/features/home/data/repo/home_repo_imple.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/splash/manager/bloc/animation_bloc.dart';

final getIt = GetIt.instance;

setup() {
  getIt.registerSingleton<ApiService>(ApiService(dio: Dio()));
  getIt.registerSingleton<HomeRepoImple>(
    HomeRepoImple(apiService: getIt<ApiService>()),
  );
  getIt.registerFactory(() => AnimationBloc());
}
