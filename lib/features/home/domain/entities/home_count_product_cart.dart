import 'package:store_me/features/home/data/models/response/get_res_product_model.dart';

class HomeProductItemEntities {
  final int count;
  final GetResProductModel product;

  HomeProductItemEntities({this.count = 1, required this.product});
}
