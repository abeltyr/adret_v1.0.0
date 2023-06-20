import 'package:adret/model/user/index.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/avatar/index.dart';
import 'package:adret/widgets/card/dateCard/index.dart';
import 'package:adret/widgets/text/column_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SummaryTopCard extends StatefulWidget {
  final UserModel? employee;
  final String date;
  final String? secondDate;
  const SummaryTopCard({
    super.key,
    this.employee,
    required this.date,
    required this.secondDate,
  });

  @override
  State<SummaryTopCard> createState() => _SummaryTopCardState();
}

class _SummaryTopCardState extends State<SummaryTopCard> {
  late DateTime firstDate;
  DateTime? secondDate;

  @override
  void initState() {
    super.initState();
    firstDate = DateTime.parse(widget.date);
    secondDate;
    if (widget.secondDate != null) {
      secondDate = DateTime.parse(widget.secondDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: DarkModePlatformTheme.fourthBlack,
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (widget.employee == null)
                DottedBorder(
                  borderType: BorderType.RRect,
                  strokeWidth: 1,
                  color: DarkModePlatformTheme.grey5,
                  padding: const EdgeInsets.all(8),
                  radius: const Radius.circular(10),
                  child: SizedBox(
                    width: 28,
                    height: 28,
                    child: SvgPicture.asset(
                      "assets/icons/bold/shop.svg",
                      color: DarkModePlatformTheme.white,
                    ),
                  ),
                )
              else
                SizedBox(
                  width: 46,
                  height: 46,
                  child: TextAvatar(
                    textData: widget.employee!.fullName ?? "",
                    fontSize: 20,
                    color: DarkModePlatformTheme.grey4,
                    textColor: DarkModePlatformTheme.grey1,
                  ),
                ),
              const SizedBox(
                width: 10,
              ),
              ColumnText(
                title: widget.employee != null
                    ? widget.employee!.fullName ??
                        AppLocalizations.of(context)!.shop
                    : AppLocalizations.of(context)!.shop,
                subText:
                    widget.employee != null && widget.employee!.userName != null
                        ? companyNameRemover(widget.employee!.userName)
                        : AppLocalizations.of(context)!.totalEarning,
                subTextSize: 14,
                titleSize: 16,
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
          Row(
            children: [
              DateCard(date: firstDate),
              if (secondDate != null)
                const SizedBox(
                  width: 5,
                ),
              if (secondDate != null)
                Container(
                  height: 1,
                  color: DarkModePlatformTheme.white,
                  margin: const EdgeInsets.symmetric(vertical: 2.5),
                  width: 15,
                ),
              if (secondDate != null)
                const SizedBox(
                  width: 5,
                ),
              if (secondDate != null)
                DateCard(
                  date: secondDate!,
                ),
            ],
          )
        ],
      ),
    );
  }
}
