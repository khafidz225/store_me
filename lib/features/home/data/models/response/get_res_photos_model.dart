// To parse this JSON data, do
//
//     final getResPhotosModel = getResPhotosModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_res_photos_model.g.dart';

GetResPhotosModel getResPhotosModelFromJson(String str) =>
    GetResPhotosModel.fromJson(json.decode(str));

String getResPhotosModelToJson(GetResPhotosModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetResPhotosModel {
  @JsonKey(name: "page")
  int page;
  @JsonKey(name: "per_page")
  int perPage;
  @JsonKey(name: "photos")
  List<Photo> photos;
  @JsonKey(name: "total_results")
  int totalResults;

  GetResPhotosModel({
    required this.page,
    required this.perPage,
    required this.photos,
    required this.totalResults,
  });

  GetResPhotosModel copyWith({
    int? page,
    int? perPage,
    List<Photo>? photos,
    int? totalResults,
  }) =>
      GetResPhotosModel(
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        photos: photos ?? this.photos,
        totalResults: totalResults ?? this.totalResults,
      );

  factory GetResPhotosModel.fromJson(Map<String, dynamic> json) =>
      _$GetResPhotosModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetResPhotosModelToJson(this);
}

@JsonSerializable()
class Photo {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "width")
  int width;
  @JsonKey(name: "height")
  int height;
  @JsonKey(name: "url")
  String url;
  @JsonKey(name: "photographer")
  String photographer;
  @JsonKey(name: "photographer_url")
  String photographerUrl;
  @JsonKey(name: "photographer_id")
  int photographerId;
  @JsonKey(name: "avg_color")
  String avgColor;
  @JsonKey(name: "src")
  Src src;
  @JsonKey(name: "liked")
  bool liked;
  @JsonKey(name: "alt")
  String alt;

  Photo({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.avgColor,
    required this.src,
    required this.liked,
    required this.alt,
  });

  Photo copyWith({
    int? id,
    int? width,
    int? height,
    String? url,
    String? photographer,
    String? photographerUrl,
    int? photographerId,
    String? avgColor,
    Src? src,
    bool? liked,
    String? alt,
  }) =>
      Photo(
        id: id ?? this.id,
        width: width ?? this.width,
        height: height ?? this.height,
        url: url ?? this.url,
        photographer: photographer ?? this.photographer,
        photographerUrl: photographerUrl ?? this.photographerUrl,
        photographerId: photographerId ?? this.photographerId,
        avgColor: avgColor ?? this.avgColor,
        src: src ?? this.src,
        liked: liked ?? this.liked,
        alt: alt ?? this.alt,
      );

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}

@JsonSerializable()
class Src {
  @JsonKey(name: "original")
  String original;
  @JsonKey(name: "large2x")
  String large2X;
  @JsonKey(name: "large")
  String large;
  @JsonKey(name: "medium")
  String medium;
  @JsonKey(name: "small")
  String small;
  @JsonKey(name: "portrait")
  String portrait;
  @JsonKey(name: "landscape")
  String landscape;
  @JsonKey(name: "tiny")
  String tiny;

  Src({
    required this.original,
    required this.large2X,
    required this.large,
    required this.medium,
    required this.small,
    required this.portrait,
    required this.landscape,
    required this.tiny,
  });

  Src copyWith({
    String? original,
    String? large2X,
    String? large,
    String? medium,
    String? small,
    String? portrait,
    String? landscape,
    String? tiny,
  }) =>
      Src(
        original: original ?? this.original,
        large2X: large2X ?? this.large2X,
        large: large ?? this.large,
        medium: medium ?? this.medium,
        small: small ?? this.small,
        portrait: portrait ?? this.portrait,
        landscape: landscape ?? this.landscape,
        tiny: tiny ?? this.tiny,
      );

  factory Src.fromJson(Map<String, dynamic> json) => _$SrcFromJson(json);

  Map<String, dynamic> toJson() => _$SrcToJson(this);
}
