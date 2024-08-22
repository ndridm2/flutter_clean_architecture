import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'features/profile/data/datasources/local_datasource.dart';
import 'features/profile/data/datasources/remote_datasource.dart';
import 'features/profile/data/models/profile_model.dart';
import 'features/profile/data/repositories/profile_repository_implementation.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/get_all_user.dart';
import 'features/profile/domain/usecases/get_user.dart';
import 'features/profile/presentation/bloc/profile/profile_bloc.dart';

var injection = GetIt.instance;

Future<void> init() async {
  // & General Dependencies
  // hive
  Hive.registerAdapter(ProfileModelAdapter());
  var box = await Hive.openBox("profile_box");
  injection.registerLazySingleton(
    () => box,
  );

  injection.registerLazySingleton(
    () => http.Client(),
  );

  // FEATURE - PROFILE
  // bloc
  injection.registerFactory(
    () => ProfileBloc(
      GetAllUser(injection()),
      GetUser(injection()),
    ),
  );

  // usecase
  injection.registerLazySingleton(() => GetAllUser(injection()));
  injection.registerLazySingleton(() => GetUser(injection()));

  // repository
  injection.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImplementation(
      profileLocalDatasource: injection(),
      profileRemoteDatasource: injection(),
      box: injection(),
    ),
  );

  // data source
  injection.registerLazySingleton<ProfileLocalDatasource>(
    () => ProfileLocalDatasourceImplementation(
      box: injection(),
    ),
  );
  injection.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasourceImplementation(
      client: injection(),
    ),
  );
}
