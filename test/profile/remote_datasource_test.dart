// ignore_for_file: avoid_print, unused_local_variable


    // & GENERATE COVERAGE
    // * RUN WITH: flutter test --machine > test.output  (file test.output)
    // * RUN WITH: flutter test --coverage || (test all data & folder on test)
    // * RUN WITH: flutter test test/name_folder --coverage || (test specific folder on test)
    // * RUN WITH: flutter test --coverage lib/test/coverage_options.dart
    // & Generate to HTML
    // * RUN WITH: genhtml coverage/lcov.info -o coverage/html --legend -t "name_legend" --function-coverage
    // & Open HTML Coverage
    // * RUN WITH: open coverage/html/index.html
    //  & Remove not coverage
    //  * RUN WITH: lcov --remove coverage/lcov.info "lib/core/error/*" "lib/features/profile/data/models/*" -o coverage/lcov.info
   
    // * GENERATE REPORT: dart tool/coverage_report.dart




import 'dart:convert';

import 'package:flutter_clean_architecture/core/error/exception.dart';
import 'package:flutter_clean_architecture/features/profile/data/datasources/remote_datasource.dart';
import 'package:flutter_clean_architecture/features/profile/data/models/profile_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'remote_datasource_test.mocks.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks(
    [MockSpec<ProfileRemoteDatasource>(), MockSpec<http.Client>()])
void main() async {
  // Create mock object.
  MockClient mockClient = MockClient();
  var remoteDatasource = MockProfileRemoteDatasource();
  var remoteDataSourceImplementation =
      ProfileRemoteDatasourceImplementation(client: mockClient);

  const int userId = 2;
  const int page = 1;
  Uri urlGetAllUser = Uri.parse("https://reqres.in/api/users?page=$page");
  Uri urlGetUser = Uri.parse("https://reqres.in/api/users/$userId");

  Map<String, dynamic> fakeDataJson = {
    "id": userId,
    "email": "janet.weaver@reqres.in",
    "first_name": "Janet",
    "last_name": "Weaver",
    "avatar": "https://reqres.in/img/faces/$userId-image.jpg"
  };

  ProfileModel fakeProfileModel = ProfileModel.fromJson(fakeDataJson);

  group('Profie Remote Data Source', () {
    group('getAllUser()', () {
      test('BERHASIL', () async {
        // proses stubbing
        when(remoteDatasource.getAllUser(page)).thenAnswer(
          (_) async => [fakeProfileModel],
        );

        try {
          var response = await remoteDatasource.getAllUser(page);
          // testing success
          expect(response, [fakeProfileModel]);
        } catch (e) {
          // testing error
          fail("Tidak mungkin terjadi");
        }
      });

      test('GAGAL', () async {
        // proses stubbing
        when(remoteDatasource.getAllUser(page)).thenThrow(Exception());

        try {
          await remoteDatasource.getAllUser(page);
          // testing success
          fail("Tidak mungkin terjadi");
        } catch (e) {
          // testing error
          expect(e, isException);
        }
      });
    });

    group('getUser()', () {
      test('BERHASIL', () async {
        // proses stubbing
        when(remoteDatasource.getUser(userId)).thenAnswer(
          (_) async => fakeProfileModel,
        );

        try {
          var response = await remoteDatasource.getUser(userId);
          // testing success
          expect(response, fakeProfileModel);
        } catch (e) {
          // testing error
          fail("Tidak mungkin terjadi");
        }
      });

      test('GAGAL', () async {
        // proses stubbing
        when(remoteDatasource.getUser(1)).thenThrow(Exception());

        try {
          await remoteDatasource.getUser(userId);
          // testing success
          fail("Tidak mungkin terjadi");
        } catch (e) {
          // testing error
          expect(e, isException);
        }
      });
    });
  });

  group("Profile Remote Data Source Implementation", () {
    group("getAllUser", () {
      test('BERHASIL (200)', () async {
        when(mockClient.get(urlGetAllUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({
              "data": [fakeDataJson],
            }),
            200,
          ),
        );

        try {
          var response = await remoteDataSourceImplementation.getAllUser(page);
          // testing success 200
          expect(response, [fakeProfileModel]);
        } on EmptyException {
          // testing error 404
          fail("Tidak mungkin terjadi");
        } on StatusCodeException {
          // testing error status code
          fail("Tidak mungkin terjadi");
        } catch (e) {
          // testing error 500
          fail("Tidak mungkin terjadi");
        }
      });

      test('GAGAL (Empty)', () async {
        when(mockClient.get(urlGetAllUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({
              "data": [],
            }),
            200,
          ),
        );

        try {
          await remoteDataSourceImplementation.getAllUser(page);
          // testing success 200
          fail("Tidak mungkin terjadi");
        } on EmptyException catch (e) {
          // testing error 404
          expect(e, isException);
        } on StatusCodeException {
          // testing error status code
          fail("Tidak mungkin terjadi");
        } catch (e) {
          // testing error 500
          fail("Tidak mungkin terjadi");
        }
      });

      test('GAGAL (404)', () async {
        when(mockClient.get(urlGetAllUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({}),
            404,
          ),
        );

        try {
          await remoteDataSourceImplementation.getAllUser(page);
          // testing success 200
          fail("Tidak mungkin terjadi");
        } on EmptyException {
          // testing error 404
          fail("Tidak mungkin terjadi");
        } on StatusCodeException catch (e) {
          // testing error status code
          expect(e, isException);
        } catch (e) {
          // testing error 500
          fail("Tidak mungkin terjadi");
        }
      });

      test('GAGAL (500)', () async {
        when(mockClient.get(urlGetAllUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({}),
            500,
          ),
        );

        try {
          await remoteDataSourceImplementation.getAllUser(page);
          // testing success 200
          fail("Tidak mungkin terjadi");
        } on EmptyException {
          // testing error 404
          fail("Tidak mungkin terjadi");
        } on StatusCodeException {
          // testing error status code
          fail("Tidak mungkin terjadi");
        } catch (e) {
          // testing untuk error 500
          expect(e, isException);
        }
      });
    });

    group("getUser", () {
      test('BERHASIL (200)', () async {
        when(mockClient.get(urlGetUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({
              "data": fakeDataJson,
            }),
            200,
          ),
        );

        try {
          var response = await remoteDataSourceImplementation.getUser(userId);
          // testing success 200
          expect(response, fakeProfileModel);
        } catch (e) {
          // testing error
          fail("Tidak mungkin terjadi");
        }
      });

      test('GAGAL (404)', () async {
        when(mockClient.get(urlGetUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({}),
            404,
          ),
        );

        try {
          await remoteDataSourceImplementation.getUser(userId);
          // testing success 200
          fail("Tidak mungkin terjadi");
        } on EmptyException catch (e) {
          // testing error 404
          expect(e, isException);
        } catch (e) {
          // testing error 500
          fail("Tidak mungkin terjadi");
        }
      });

      test('GAGAL (500)', () async {
        when(mockClient.get(urlGetUser))
            .thenAnswer((_) async => http.Response(jsonEncode({}), 500));

        try {
          await remoteDataSourceImplementation.getUser(userId);
          // testing success 200
          fail("Tidak mungkin terjadi");
        } on EmptyException {
          // testing error 404
          fail("Tidak mungkin terjadi");
        } catch (e) {
          // testing error 500
          expect(e, isException);
        }
      });
    });
  });
}
