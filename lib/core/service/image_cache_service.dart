import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class ImageCacheService {
  static final ImageCacheService _instance = ImageCacheService._instance;
  factory ImageCacheService() => _instance;

  static Widget getNetworkImage(
      {required String imageUrl, double? width, double? height}) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (context, url) => CardLoading(
        width: width,
        height: height ?? 150,
        borderRadius: BorderRadius.circular(20),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }
}
