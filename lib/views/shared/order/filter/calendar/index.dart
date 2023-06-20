import 'package:adret/widgets/card/dateCard/index.dart';
import 'package:flutter/material.dart';
import 'package:adret/utils/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Calendar extends StatefulWidget {
  final String? sellerId;
  final DateTime startDate;
  final DateTime endDate;
  final Function(DateTime) updateStartDate;
  final Function(DateTime) updateEndDate;
  const Calendar({
    Key? key,
    this.sellerId,
    required this.startDate,
    required this.endDate,
    required this.updateStartDate,
    required this.updateEndDate,
  }) : super(key: key);
  static const routeName = '/calendar';

  @override
  State<Calendar> createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      widget.updateStartDate(args.value.startDate);
      widget.updateEndDate(args.value.endDate ?? args.value.startDate);
    } else if (args.value is DateTime) {
      widget.updateStartDate(args.value);
      widget.updateEndDate(args.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            reverseDuration: const Duration(milliseconds: 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateCard(date: widget.startDate),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: DarkModePlatformTheme.grey5,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                DateCard(date: widget.endDate)
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 2 / 3,
          decoration: BoxDecoration(
            color: DarkModePlatformTheme.grey1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SfDateRangePicker(
            onSelectionChanged: onSelectionChanged,
            selectionMode: widget.sellerId == null
                ? DateRangePickerSelectionMode.range
                : DateRangePickerSelectionMode.single,
            maxDate: widget.sellerId == null
                ? DateTime.now().add(const Duration(days: 1))
                : DateTime.now(),
            allowViewNavigation: true,
            startRangeSelectionColor: DarkModePlatformTheme.primary,
            endRangeSelectionColor: DarkModePlatformTheme.primary,
            rangeSelectionColor: DarkModePlatformTheme.primaryLight3,
            todayHighlightColor: DarkModePlatformTheme.grey2,
            monthViewSettings: const DateRangePickerMonthViewSettings(
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: TextStyle(
                color: DarkModePlatformTheme.grey4,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
              ),
            )),
            selectionTextStyle: const TextStyle(
              color: DarkModePlatformTheme.primaryDark2,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              wordSpacing: 1,
            ),
            rangeTextStyle: const TextStyle(
              color: DarkModePlatformTheme.primaryDark2,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              wordSpacing: 1,
            ),
            headerStyle: const DateRangePickerHeaderStyle(
              textStyle: TextStyle(
                color: DarkModePlatformTheme.grey6,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                fontSize: 20,
                wordSpacing: 1,
              ),
            ),
            yearCellStyle: const DateRangePickerYearCellStyle(
              textStyle: TextStyle(
                color: DarkModePlatformTheme.grey6,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                wordSpacing: 1,
              ),
              todayTextStyle: TextStyle(
                color: DarkModePlatformTheme.grey6,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                wordSpacing: 1,
              ),
              disabledDatesDecoration: BoxDecoration(),
              disabledDatesTextStyle: TextStyle(
                color: DarkModePlatformTheme.grey3,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
              ),
            ),
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: const TextStyle(
                color: DarkModePlatformTheme.grey6,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                wordSpacing: 1,
              ),
              todayTextStyle: const TextStyle(
                color: DarkModePlatformTheme.grey6,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                wordSpacing: 1,
              ),
              todayCellDecoration: BoxDecoration(
                color: DarkModePlatformTheme.grey2,
                borderRadius: BorderRadius.circular(10),
              ),
              disabledDatesTextStyle: const TextStyle(
                color: DarkModePlatformTheme.grey3,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
              ),
            ),
            headerHeight: 60,
            selectionColor: DarkModePlatformTheme.grey6,
            selectionShape: DateRangePickerSelectionShape.rectangle,
            initialSelectedRange:
                PickerDateRange(widget.startDate, widget.endDate),
            initialSelectedDate: widget.startDate,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
