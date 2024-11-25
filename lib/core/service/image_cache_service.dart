import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class ImageCacheService {
  static final ImageCacheService _instance = ImageCacheService._instance;
  factory ImageCacheService() => _instance;

  static Widget getNetworkImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => CardLoading(
        height: 200,
        borderRadius: BorderRadius.circular(16),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }
}
