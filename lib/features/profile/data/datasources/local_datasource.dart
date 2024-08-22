import 'package:hive/hive.dart';
import '../models/profile_model.dart';

abstract class ProfileLocalDatasource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileLocalDatasourceImplementation extends ProfileLocalDatasource {
  
  final Box box;
  ProfileLocalDatasourceImplementation({required this.box});

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    return box.get("getAllUser");
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    return box.get("getUser");
  }

}