import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/widgets/shimmer/shimmer.dart';

class LoadingHome extends StatelessWidget {
  const LoadingHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: const [
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
