import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/text/column_text_loading.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalCardLoading extends StatelessWidget {
  const HorizontalCardLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DarkModePlatformTheme.fourthBlack,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Shimmer.fromColors(
        baseColor: DarkModePlatformTheme.darkWhite1,
        highlightColor: DarkModePlatformTheme.darkWhite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: DarkModePlatformTheme.white,
                  ),
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(8),
                )),
            const SizedBox(
              width: 10,
            ),
            const Expanded(
              child: ColumnTextLoading(),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
