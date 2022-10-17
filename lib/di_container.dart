import 'package:dio/dio.dart';
import 'package:practice_2/data/datasource/dio_user.dart';
import 'package:practice_2/data/repository/user_repo.dart';
import 'package:practice_2/provider/user_provider.dart';
import 'package:practice_2/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioUser(AppConstants.BASE_URL,Dio()));

  // Repository
  sl.registerLazySingleton(() => UserRepo(dioUser: sl(), sharedPreferences: sl()));

  // Provider
  sl.registerFactory(() => UserProvider(userRepo: sl()));


  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}
