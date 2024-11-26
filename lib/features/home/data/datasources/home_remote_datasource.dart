import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_me/core/enum/key_local_storage_enum.dart';
import 'package:store_me/features/home/data/models/response/get_res_product_model.dart';

import '../../../../core/config/api_config.dart';
import '../../../../core/di/depedency_injection.dart';
import '../../../../core/error/exception.dart';
import '../../../auth/data/models/response/get_res_all_user.dart';
import '../models/response/get_res_photos_model.dart';

abstract class HomeRemoteDatasource {
  Future<List<GetResProductModel>> getProduct();
  Future<List<GetResProductModel>> getProductFromCategory(
      {required String category});
  Future<List<String>> getCategory();
  Future<GetResAllUser> getMyProfile();
}

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  @override
  Future<List<GetResProductModel>> getProduct() async {
    try {
      final response = await locator<Dio>().get(ApiConfig.products);
      if (response.statusCode != 200) {
        return Future.error(GeneralException(message: response.data));
      }
      if (response.data is List) {
        List<GetResProductModel> valueResponseModel = (response.data as List)
            .map((json) => GetResProductModel.fromJson(json))
            .toList();

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
  Future<List<GetResProductModel>> getProductFromCategory(
      {required String category}) async {
    try {
      print('Tag: ${ApiConfig.productFromCategory}/$category');
      final response = await locator<Dio>()
          .get('${ApiConfig.productFromCategory}/$category');
      if (response.statusCode != 200) {
        return Future.error(GeneralException(message: response.data));
      }

      print('Response data: ${response.data}');

      if (response.data is List) {
        List<GetResProductModel> valueResponseModel = (response.data as List)
            .map((json) => GetResProductModel.fromJson(json))
            .toList();

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
  Future<List<String>> getCategory() async {
    try {
      final response = await locator<Dio>().get(ApiConfig.categories);
      if (response.statusCode != 200) {
        return Future.error(GeneralException(message: response.data));
      }
      if (response.data is List) {
        List<String> valueResponseModel =
            (response.data as List).map((json) => json.toString()).toList();

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
  Future<GetResAllUser> getMyProfile() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? userId = pref.getString(KeyLocalStorageEnum.user_id.name);
      if (userId == null) {
        return Future.error(
            const GeneralException(message: 'You dont have User Id'));
      }
      final response = await locator<Dio>().get('${ApiConfig.user}/$userId');
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
}
