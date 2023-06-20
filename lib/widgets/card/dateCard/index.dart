import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCard extends StatelessWidget {
  final DateTime date;
  const DateCard({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: DarkModePlatformTheme.white,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          SizedBox(
            child: Column(
              children: [
                Text(
                  DateFormat("dd").format(date),
                  style: const TextStyle(
                    color: DarkModePlatformTheme.grey4,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    wordSpacing: 1,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  DateFormat("MMM").format(date),
                  style: const TextStyle(
                    color: DarkModePlatformTheme.grey6,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    wordSpacing: 1,
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
