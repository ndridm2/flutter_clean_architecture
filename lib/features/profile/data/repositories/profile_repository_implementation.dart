import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImplementation extends ProfileRepository {
  final ProfileLocalDatasource profileLocalDatasource;
  final ProfileRemoteDatasource profileRemoteDatasource;
  final Box box;

  ProfileRepositoryImplementation({
    required this.profileLocalDatasource,
    required this.profileRemoteDatasource,
    required this.box
  });

  @override
  Future<Either<Failure, List<Profile>>> getAllUser(int page) async {
    // *Check Internet
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // No available network types
        // local datasource
        List<ProfileModel> result =
            await profileLocalDatasource.getAllUser(page);
        return Right(result);
      } else {
        // Available network
        // remote datasource
        List<ProfileModel> result =
            await profileRemoteDatasource.getAllUser(page);

        // update box profile local datasource
        box.put("getAllUser", result);

        return Right(result);
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Profile>> getUser(int id) async {
    // *Check Internet
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // No available network types
        // local datasource
        ProfileModel result = await profileLocalDatasource.getUser(id);
        return Right(result);
      } else {
        // Available network
        // remote datasource
        ProfileModel result = await profileRemoteDatasource.getUser(id);

        // update box profile local datasource
        box.put("getUser", result);

        return Right(result);
      }
    } catch (e) {
      return Left(Failure());
    }
  }
}
