import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/widgets/library/shimmer/shimmer.dart';

class LoadingListEHome extends StatelessWidget {
  const LoadingListEHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const VideoShimmer();
  }
}

class LoadingListPHome extends StatelessWidget {
  const LoadingListPHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerPro.generated(
        scaffoldBackgroundColor: Colors.transparent,
        child: Column(
          children: [
            ShimmerPro.sized(
              scaffoldBackgroundColor: Colors.white,
              height: 75,
              width: Get.width,
              depth: 40,
              duration: const Duration(milliseconds: 500),
            ),
            ShimmerPro.sized(
              scaffoldBackgroundColor: Colors.white,
              height: 75,
              width: Get.width,
              depth: 40,
              duration: const Duration(milliseconds: 500),
            ),
          ],
        ));
  }
}

class LoadingList extends StatelessWidget {
  const LoadingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ProfileShimmer(),
          ProfileShimmer(),
          ProfileShimmer(),
          ProfileShimmer(),
          ProfileShimmer(),
          ProfileShimmer(),
        ],
      ),
    );
  }
}
