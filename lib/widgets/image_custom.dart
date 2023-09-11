import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:photo_view/photo_view.dart';

import 'library/shimmer/shimmer.dart';

Widget imageNetwork(
    {required String url,
    BoxFit? fit,
    Color? color,
    double? height,
    double? width,
    double scale = 1.0,
    AlignmentGeometry alignment = Alignment.center,
    int? cacheHeight,
    int? cacheWidth,
    Animation<double>? opacity,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    bool matchTextDirection = false,
    BlendMode? colorBlendMode,
    Rect? centerSlice,
    Map<String, String>? headers,
    FilterQuality filterQuality = FilterQuality.low,
    Key? key,
    String? semanticLabel}) {
  return Image.network(
    url,
    fit: fit,
    color: color,
    height: height,
    width: width,
    scale: scale,
    alignment: alignment,
    cacheHeight: cacheHeight,
    cacheWidth: cacheWidth,
    opacity: opacity,
    repeat: repeat,
    matchTextDirection: matchTextDirection,
    colorBlendMode: colorBlendMode,
    errorBuilder: (context, object, stackTrace) {
      return SizedBox(
        height: double.infinity,
        child: Image.asset(
          'assets/images/image_notfound.jpg',
          fit: fit ?? BoxFit.fill,
        ),
      );
    },
    centerSlice: centerSlice,
    headers: headers,
    filterQuality: filterQuality,
    key: key,
    semanticLabel: semanticLabel,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
          child: ShimmerPro.sized(
              scaffoldBackgroundColor: Colors.grey.shade200,
              height: double.infinity,
              width: double.infinity));
    },
  );
}

class ViewImageWithZoom extends StatelessWidget {
  const ViewImageWithZoom({Key? key, required this.url, required this.index})
      : super(key: key);
  final String url;
  final num index;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero_show_image$index',
      child: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(url),
            minScale: 0.0,
            maxScale: 3.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: IconButton(
                color: Get.theme.colorScheme.onBackground.withOpacity(0.3),
                icon: Icon(
                  LucideIcons.x,
                  color: Get.theme.colorScheme.background,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
