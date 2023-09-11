import 'package:flutter/material.dart';
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
    return const SingleChildScrollView(
    child: Column(
    children:  [
      PlayStoreShimmer()
    ],
    ),
    );
  }
}