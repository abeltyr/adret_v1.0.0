import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/card/iconText/loading.dart';
import 'package:adret/widgets/text/column_text_loading.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SummaryCardLoading extends StatelessWidget {
  final Color? color;
  final bool showButton;
  final bool isManger;
  const SummaryCardLoading({
    super.key,
    this.color = DarkModePlatformTheme.fourthBlack,
    this.showButton = false,
    this.isManger = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 30),
      child: Column(
        children: [
          if (isManger)
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: DarkModePlatformTheme.fourthBlack.withOpacity(0.2),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Shimmer.fromColors(
                baseColor: DarkModePlatformTheme.darkWhite1,
                highlightColor: DarkModePlatformTheme.darkWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: DarkModePlatformTheme.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const ColumnTextLoading(
                          height: 16,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: DarkModePlatformTheme.primaryLight2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: DarkModePlatformTheme.primaryLight2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: showButton && isManger
                  ? Border.all(
                      width: 1,
                      color: DarkModePlatformTheme.grey1,
                    )
                  : null,
            ),
            padding: EdgeInsets.all(showButton && isManger ? 8 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: DarkModePlatformTheme.fourthBlack.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Shimmer.fromColors(
                          baseColor: DarkModePlatformTheme.darkWhite1,
                          highlightColor: DarkModePlatformTheme.darkWhite,
                          child: const IconTextCardLoading(
                            size: 32,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Shimmer.fromColors(
                          baseColor: DarkModePlatformTheme.darkWhite1,
                          highlightColor: DarkModePlatformTheme.darkWhite,
                          child: const IconTextCardLoading(
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (showButton && isManger)
                  const SizedBox(
                    height: 8,
                  ),
                if (showButton && isManger)
                  Shimmer.fromColors(
                    baseColor: DarkModePlatformTheme.darkWhite1,
                    highlightColor: DarkModePlatformTheme.darkWhite,
                    child: Container(
                      decoration: BoxDecoration(
                        color: DarkModePlatformTheme.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      height: 40,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
