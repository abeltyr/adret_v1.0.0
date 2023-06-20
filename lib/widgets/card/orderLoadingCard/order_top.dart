import 'package:adret/utils/theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class OrderTopLoading extends StatelessWidget {
  const OrderTopLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Row(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                strokeWidth: 1,
                color: DarkModePlatformTheme.grey5,
                padding: const EdgeInsets.all(8),
                radius: const Radius.circular(10),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: DarkModePlatformTheme.grey3,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: DarkModePlatformTheme.grey3,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: 80,
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: DarkModePlatformTheme.grey3,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: DarkModePlatformTheme.grey3,
          ),
        ),
      ],
    );
  }
}
