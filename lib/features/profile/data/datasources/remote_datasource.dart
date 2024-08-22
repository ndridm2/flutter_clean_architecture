import 'dart:convert';

import '../../../../core/error/exception.dart';
import 'package:http/http.dart' as http;
import '../models/profile_model.dart';

abstract class ProfileRemoteDatasource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileRemoteDatasourceImplementation extends ProfileRemoteDatasource {
  final http.Client client;
  ProfileRemoteDatasourceImplementation({required this.client});

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    Uri url = Uri.parse("https://reqres.in/api/users?page=$page");
    var response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> getData = jsonDecode(response.body);
      List<dynamic> data = getData["data"];
      if (data.isEmpty) throw const EmptyException(message: "Empty data");
      return ProfileModel.fromJsonList(data);

    } else if (response.statusCode == 404) {
      throw const StatusCodeException(message: "Data not found, error 404");
    } else {
      throw const GeneralException(message: "Cannot get data");
    }
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    Uri url = Uri.parse("https://reqres.in/api/users/$id");
    var response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> getData = jsonDecode(response.body);
      Map<String, dynamic> data = getData["data"];
      return ProfileModel.fromJson(data);

    } else if (response.statusCode == 404) {
      throw const EmptyException(message: "Data not found!");
    } else {
      throw const GeneralException(message: "Cannot get data");
    }
  }
}
