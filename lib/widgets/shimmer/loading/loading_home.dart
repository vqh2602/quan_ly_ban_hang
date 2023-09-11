import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/widgets/shimmer/shimmer.dart';

class LoadingHome extends StatelessWidget {
  const LoadingHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          ProfilePageShimmer(),
          VideoShimmer(),
          VideoShimmer(isRectBox: true, hasBottomBox: true),
          ListTileShimmer(),
          ListTileShimmer(),
          ListTileShimmer(),
          ListTileShimmer(),
          ListTileShimmer(),
        ],
      ),
    ));
  }
}
