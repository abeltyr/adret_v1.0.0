import 'dart:math';

import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductLoadingCard extends StatelessWidget {
  const ProductLoadingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: DarkModePlatformTheme.fourthBlack,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: DarkModePlatformTheme.fourthBlack,
        ),
      ),
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints snapshot) {
          return Shimmer.fromColors(
            baseColor: DarkModePlatformTheme.darkWhite,
            highlightColor: DarkModePlatformTheme.darkWhite1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: snapshot.maxWidth * 2 / 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: DarkModePlatformTheme.fourthBlack,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: SizedBox(
                    height: 65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 80 + (Random().nextInt(40).toDouble()),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: DarkModePlatformTheme.fourthBlack,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 16,
                              width: 50 + (Random().nextInt(30).toDouble()),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: DarkModePlatformTheme.fourthBlack,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              height: 16,
                              width: 50 + (Random().nextInt(30).toDouble()),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: DarkModePlatformTheme.fourthBlack,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Shimmer.fromColors(
                  baseColor: DarkModePlatformTheme.darkWhite,
                  highlightColor: DarkModePlatformTheme.darkWhite1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 16,
                        width: 30 + (Random().nextInt(20).toDouble()),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: DarkModePlatformTheme.fourthBlack,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 16,
                        width: 40 + (Random().nextInt(30).toDouble()),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: DarkModePlatformTheme.fourthBlack,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
