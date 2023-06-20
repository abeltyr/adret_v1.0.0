import 'package:adret/model/user/index.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:adret/widgets/card/iconText/index.dart';
import 'package:adret/widgets/popup/message/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ManagerSummaryCard extends StatefulWidget {
  final String sales;
  final String profit;
  final UserModel? employee;
  final bool collected;
  final Function onClick;
  final String date;
  const ManagerSummaryCard({
    super.key,
    required this.sales,
    required this.profit,
    required this.employee,
    required this.collected,
    required this.onClick,
    required this.date,
  });

  @override
  State<ManagerSummaryCard> createState() => _ManagerSummaryCardState();
}

class _ManagerSummaryCardState extends State<ManagerSummaryCard> {
  bool loading = false;
  String title = "Collect";

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateLoading();
  }

  updateLoading() {
    if (loading) {
      title = (AppLocalizations.of(context)!.collecting);
    } else if (!loading) {
      title = (AppLocalizations.of(context)!.collect);
    }
    if (widget.collected) title = (AppLocalizations.of(context)!.collected);
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant ManagerSummaryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateLoading();
  }

  @override
  Widget build(BuildContext context) {
    final double sales = double.tryParse(widget.sales) ?? 0;
    final double profit = double.tryParse(widget.profit) ?? 0;
    final lang = Localizations.localeOf(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: widget.employee != null
            ? Border.all(
                width: 1,
                color: DarkModePlatformTheme.grey1,
              )
            : null,
      ),
      padding: EdgeInsets.all(widget.employee != null ? 8 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: widget.employee != null ? 12 : 16, horizontal: 16),
            decoration: BoxDecoration(
              color: DarkModePlatformTheme.fourthBlack,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconTextCard(
                        title: AppLocalizations.of(context)!.earning,
                        subTitle:
                            '${priceShow(widget.sales)} ${AppLocalizations.of(context)!.etb}',
                        icon: "assets/icons/bold/receiptSecond.svg",
                        titleFontSize: '$lang' == "en"
                            ? widget.employee != null
                                ? 16
                                : 18
                            : 14,
                        iconSize: widget.employee != null ? 38 : 40,
                        titleColor: sales > 0
                            ? DarkModePlatformTheme.positiveLight2
                            : sales == 0
                                ? DarkModePlatformTheme.grey4
                                : DarkModePlatformTheme.negativeLight3,
                        subTitleColor: sales > 0
                            ? DarkModePlatformTheme.positiveLight3
                            : sales == 0
                                ? DarkModePlatformTheme.grey5
                                : DarkModePlatformTheme.negativeLight3,
                        iconColor: sales > 0
                            ? DarkModePlatformTheme.positiveLight3
                            : sales == 0
                                ? DarkModePlatformTheme.grey5
                                : DarkModePlatformTheme.negativeLight3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  height: 45,
                  width: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DarkModePlatformTheme.grey5,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconTextCard(
                        title: AppLocalizations.of(context)!.profit,
                        subTitle:
                            '${priceShow(widget.profit)} ${AppLocalizations.of(context)!.etb}',
                        icon: "assets/icons/bold/moneys.svg",
                        titleFontSize: '$lang' == "en"
                            ? widget.employee != null
                                ? 16
                                : 18
                            : 14,
                        // subTitleFontSize: 20,
                        iconSize: widget.employee != null ? 38 : 40,
                        titleColor: profit > 0
                            ? DarkModePlatformTheme.positiveLight2
                            : profit == 0
                                ? DarkModePlatformTheme.grey4
                                : DarkModePlatformTheme.negativeLight3,
                        subTitleColor: profit > 0
                            ? DarkModePlatformTheme.positiveLight3
                            : profit == 0
                                ? DarkModePlatformTheme.grey5
                                : DarkModePlatformTheme.negativeLight3,
                        iconColor: profit > 0
                            ? DarkModePlatformTheme.positiveLight3
                            : profit == 0
                                ? DarkModePlatformTheme.grey5
                                : DarkModePlatformTheme.negativeLight3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: widget.employee != null ? 8 : 0,
          ),
          if (widget.employee != null)
            SizedBox(
              // width: MediaQuery.of(context).size.width - 70,
              child: SizedBox(
                height: 45,
                child: MainButton(
                    title: title,
                    borderRadiusData: 10,
                    disabled: widget.collected,
                    loading: loading,
                    color: DarkModePlatformTheme.primary,
                    textColor: DarkModePlatformTheme.primaryDark2,
                    icon: widget.collected
                        ? "assets/icons/moneyAdded.svg"
                        : "assets/icons/moneyAdd.svg",
                    textFontSize: 22,
                    iconLoading: "assets/icons/moneyLoading.svg",
                    onClick: () async {
                      if (!widget.collected) {
                        setState(() {
                          loading = true;
                        });
                        updateLoading();
                        try {
                          showCupertinoDialog(
                            context: context,
                            builder: (_) => MessagePopUp(
                              cancelColor: DarkModePlatformTheme.white,
                              acceptColor: DarkModePlatformTheme.primary,
                              acceptTextColor:
                                  DarkModePlatformTheme.primaryDark2,
                              cancelTextColor: DarkModePlatformTheme.thirdBlack,
                              acceptFunction: () {
                                setState(() {
                                  loading = false;
                                });
                                updateLoading();
                              },
                              cancelFunction: () async {
                                await widget.onClick();
                                setState(() {
                                  loading = false;
                                });
                                updateLoading();
                              },
                              title:
                                  "${AppLocalizations.of(context)!.collectEmployee} ${widget.employee != null ? widget.employee!.fullName ?? "" : ""} ${'$lang' == "en" ? "" : '${AppLocalizations.of(context)!.on} '}${DateFormat.yMMMd().format(DateTime.parse(widget.date))} ${'$lang' == "en" ? AppLocalizations.of(context)!.earning : AppLocalizations.of(context)!.collectEmployeeEnd}",
                              subText: AppLocalizations.of(context)!
                                  .collectEmployeeCaution,
                              cancel: AppLocalizations.of(context)!.collect,
                              accept: AppLocalizations.of(context)!.cancel,
                            ),
                          );
                        } catch (e) {
                          // print(e);
                        }
                      }
                    }),
              ),
            ),
        ],
      ),
    );
  }
}
