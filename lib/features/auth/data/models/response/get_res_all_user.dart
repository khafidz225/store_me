// To parse this JSON data, do
//
//     final getResAllUser = getResAllUserFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_res_all_user.g.dart';

List<GetResAllUser> getResAllUserFromJson(String str) =>
    List<GetResAllUser>.from(
        json.decode(str).map((x) => GetResAllUser.fromJson(x)));

String getResAllUserToJson(List<GetResAllUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class GetResAllUser {
  @JsonKey(name: "address")
  Address address;
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "username")
  String username;
  @JsonKey(name: "password")
  String password;
  @JsonKey(name: "name")
  Name name;
  @JsonKey(name: "phone")
  String phone;
  @JsonKey(name: "__v")
  int v;

  GetResAllUser({
    required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.v,
  });

  factory GetResAllUser.fromJson(Map<String, dynamic> json) =>
      _$GetResAllUserFromJson(json);

  Map<String, dynamic> toJson() => _$GetResAllUserToJson(this);
}

@JsonSerializable()
class Address {
  @JsonKey(name: "geolocation")
  Geolocation geolocation;
  @JsonKey(name: "city")
  String city;
  @JsonKey(name: "street")
  String street;
  @JsonKey(name: "number")
  int number;
  @JsonKey(name: "zipcode")
  String zipcode;

  Address({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Geolocation {
  @JsonKey(name: "lat")
  String lat;
  @JsonKey(name: "long")
  String long;

  Geolocation({
    required this.lat,
    required this.long,
  });

  factory Geolocation.fromJson(Map<String, dynamic> json) =>
      _$GeolocationFromJson(json);

  Map<String, dynamic> toJson() => _$GeolocationToJson(this);
}

@JsonSerializable()
class Name {
  @JsonKey(name: "firstname")
  String firstname;
  @JsonKey(name: "lastname")
  String lastname;

  Name({
    required this.firstname,
    required this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);
}
