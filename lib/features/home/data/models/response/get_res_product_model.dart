// To parse this JSON data, do
//
//     final getResProductModel = getResProductModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_res_product_model.g.dart';

List<GetResProductModel> getResProductModelFromJson(String str) =>
    List<GetResProductModel>.from(
        json.decode(str).map((x) => GetResProductModel.fromJson(x)));

String getResProductModelToJson(List<GetResProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class GetResProductModel {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "price")
  double price;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "category")
  String category;
  @JsonKey(name: "image")
  String image;
  @JsonKey(name: "rating")
  Rating rating;

  GetResProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory GetResProductModel.fromJson(Map<String, dynamic> json) =>
      _$GetResProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetResProductModelToJson(this);
}

@JsonSerializable()
class Rating {
  @JsonKey(name: "rate")
  double rate;
  @JsonKey(name: "count")
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
