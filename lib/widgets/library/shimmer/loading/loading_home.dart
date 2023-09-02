import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/widgets/library/shimmer/shimmer.dart';

class LoadingHome extends StatelessWidget {
  const LoadingHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: const[
                // ProfilePageShimmer(),
                VideoShimmer(),
                // VideoShimmer(isRectBox: false, hasBottomBox: true,),
                ListTileShimmer(),
                ListTileShimmer(),
                ListTileShimmer(),
                ListTileShimmer(),
                ListTileShimmer(),
              ],
            ),
          )),
    );
  }
}
