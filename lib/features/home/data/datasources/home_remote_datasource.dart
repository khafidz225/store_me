import 'package:dio/dio.dart';

import '../../../../core/config/api_config.dart';
import '../../../../core/di/depedency_injection.dart';
import '../../../../core/error/exception.dart';
import '../models/response/get_res_photos_model.dart';

abstract class HomeRemoteDatasource {
  Future<GetResPhotosModel> getPhotos(
      {required int perPage, required int page});
}

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  @override
  Future<GetResPhotosModel> getPhotos(
      {required int perPage, required int page}) async {
    try {
      final response =
          await locator<Dio>().get(ApiConfig.curatedPhoto, queryParameters: {
        // 'query': 'nature',
        'per_page': perPage,
        'page': page
      });
      if (response.statusCode != 200) {
        return Future.error(GeneralException(message: response.data));
      }

      GetResPhotosModel valueResponseModel =
          GetResPhotosModel.fromJson(response.data);

      return valueResponseModel;
    } on DioException catch (error) {
      return Future.error(GeneralException(message: error.response?.data));
    } catch (error) {
      return Future.error(GeneralException(message: error.toString()));
    }
  }
}
