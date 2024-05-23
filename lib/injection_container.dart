import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crud/core/network/network_info.dart';
import 'package:crud/core/transaction/transaction_queue.dart';
import 'package:crud/features/users/domain/usecases/create_user.dart';
import 'package:crud/features/users/domain/usecases/update_user.dart';
import 'package:crud/features/users/domain/usecases/get_user.dart';
import 'package:crud/features/users/domain/usecases/get_all_users.dart';
import 'package:crud/features/users/domain/usecases/delete_user.dart';
import 'package:crud/features/users/data/repositories/user_repository_impl.dart';
import 'package:crud/features/users/data/datasources/user_remote_data_source.dart';
import 'package:crud/features/users/presentation/bloc/user_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/users/domain/repositories/user_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<TransactionQueue>(() => TransactionQueue(sl()));

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(client: sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteDataSource: sl()));

  // Use cases
  sl.registerLazySingleton(() => CreateUser(sl(), sl(), sl()));
  sl.registerLazySingleton(() => UpdateUser(sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => GetAllUsers(sl()));
  sl.registerLazySingleton(() => DeleteUser(sl()));

  // Bloc
  sl.registerFactory(
        () => UserBloc(
      createUser: sl(),
      updateUser: sl(),
      getUser: sl(),
      getAllUsers: sl(),
      deleteUser: sl(),
    ),
  );
}

