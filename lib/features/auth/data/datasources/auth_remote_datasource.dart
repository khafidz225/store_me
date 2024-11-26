import 'package:dio/dio.dart';
import 'package:store_me/features/auth/data/models/response/get_res_all_user.dart';

import '../../../../core/config/api_config.dart';
import '../../../../core/di/depedency_injection.dart';
import '../../../../core/error/exception.dart';

abstract class AuthRemoteDatasource {
  Future<GetResAllUser> getUser({required int id});
  Future<List<GetResAllUser>> getAllUser();
  Future<String> postLogin(
      {required String username, required String password});
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  @override
  Future<GetResAllUser> getUser({required int id}) async {
    try {
      final response = await locator<Dio>().get('${ApiConfig.user}/$id');
      if (response.statusCode != 200) {
        return Future.error(GeneralException(message: response.data));
      }

      GetResAllUser valueResponseModel = GetResAllUser.fromJson(response.data);

      return valueResponseModel;
    } on DioException catch (error) {
      return Future.error(GeneralException(message: error.response?.data));
    } catch (error) {
      return Future.error(GeneralException(message: error.toString()));
    }
  }

  @override
  Future<List<GetResAllUser>> getAllUser() async {
    try {
      final response = await locator<Dio>().get(ApiConfig.user);
      if (response.statusCode != 200) {
        return Future.error(GeneralException(message: response.data));
      }

      if (response.data is List) {
        // Konversi respons JSON menjadi List<GetResAllUser>
        List<GetResAllUser> valueResponseModel = (response.data as List)
            .map((json) => GetResAllUser.fromJson(json as Map<String, dynamic>))
            .toList();

        // Tampilkan hasil
        for (var user in valueResponseModel) {
          print(
              'ID: ${user.id}, Name: ${user.name.firstname} ${user.name.lastname}');
        }
        return valueResponseModel;
      } else {
        return Future.error(
            const GeneralException(message: 'Unexpected response format'));
      }
    } on DioException catch (error) {
      return Future.error(GeneralException(message: error.response?.data));
    } catch (error) {
      return Future.error(GeneralException(message: error.toString()));
    }
  }

  @override
  Future<String> postLogin(
      {required String username, required String password}) async {
    try {
      final response = await locator<Dio>().post(ApiConfig.login, data: {
        "username": username,
        "password": password,
      });
      if (response.statusCode != 200) {
        return Future.error(GeneralException(message: response.data));
      }

      String valueResponseModel = response.data['token'];

      return valueResponseModel;
    } on DioException catch (error) {
      return Future.error(GeneralException(message: error.response?.data));
    } catch (error) {
      return Future.error(GeneralException(message: error.toString()));
    }
  }
}
