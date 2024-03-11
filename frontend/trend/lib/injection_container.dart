import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/core/bloc/theme_cubit/theme_cubit.dart';

import 'config/locale/localization_cubit/localization_cubit.dart';
import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/network_info.dart';
import 'core/repositories/repository_handler.dart';
import 'core/utils/shared_pref.dart';
import 'features/authentication/data/data_source/auth_remote_data_source.dart';
import 'features/authentication/data/repository/auth_repository.dart';
import 'features/authentication/data/repository/auth_repository_impl.dart';
import 'features/authentication/presentation/bloc/auth_bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  _initAuth();
  await _registerCoreAndExternal();
}

void _initAuth() {
  //bloc
  sl.registerFactory(() => AuthBloc(
        authRepository: sl(),
      ));

  //repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        authRemoteDataSource: sl(),
        networkInfo: sl(),
        sharedPref: sl(),
        repositoryHandler: sl(),
      ));

  //data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(apiConsumer: sl()));
}

Future<void> _registerCoreAndExternal() async {
  //! Core

  sl.registerFactory(() => LocalizationCubit(sharedPref: sl()));
  sl.registerFactory(() => ThemeCubit(sharedPref: sl()));
  sl.registerLazySingleton(() => SharedPref(sharedPreferences: sl()));

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
  sl.registerLazySingleton<RepositoryHandler>(() => RepositoryHandlerImpl());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppIntercepters());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
