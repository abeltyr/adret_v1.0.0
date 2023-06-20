import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserLoadingCard extends StatelessWidget {
  const UserLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: DarkModePlatformTheme.darkWhite,
      highlightColor: DarkModePlatformTheme.white,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: DarkModePlatformTheme.fourthBlack,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: DarkModePlatformTheme.fourthBlack,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: 30,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: DarkModePlatformTheme.fourthBlack,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
