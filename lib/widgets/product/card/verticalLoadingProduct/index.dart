import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VerticalLoadingProduct extends StatelessWidget {
  const VerticalLoadingProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: MediaQuery.of(context).size.width / 3.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: DarkModePlatformTheme.secondBlack,
      ),
      child: Shimmer.fromColors(
        baseColor: DarkModePlatformTheme.darkWhite1,
        highlightColor: DarkModePlatformTheme.darkWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 104,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: DarkModePlatformTheme.darkWhite,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: (MediaQuery.of(context).size.width / 3.5) - 30,
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: DarkModePlatformTheme.darkWhite,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: (MediaQuery.of(context).size.width / 3.5) - 60,
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: DarkModePlatformTheme.darkWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
