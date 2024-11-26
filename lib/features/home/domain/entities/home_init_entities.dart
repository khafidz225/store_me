import 'package:store_me/features/auth/data/models/response/get_res_all_user.dart';

import '../../data/models/response/get_res_product_model.dart';

class HomeInitEntities {
  final List<GetResProductModel> product;
  final List<String> category;
  final GetResAllUser user;

  HomeInitEntities(
      {required this.product, required this.category, required this.user});
}
