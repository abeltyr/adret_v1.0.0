import 'package:adret/services/orders/index.dart';
import 'package:adret/services/summary/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/header/sliderHeader/index.dart';
import 'package:flutter/material.dart';
import 'package:adret/widgets/header/textHeader/index.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'calendar/index.dart';
import 'employees/index.dart';

class SalesFilter extends StatefulWidget {
  const SalesFilter({super.key});

  @override
  State<SalesFilter> createState() => _SalesFilterState();
}

class _SalesFilterState extends State<SalesFilter> {
  int index = 0;
  String? sellerId;
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    final orderService = Provider.of<OrderService>(context, listen: false);
    sellerId = orderService.sellerId;
    startDate = orderService.startDate;
    endDate = orderService.endDate;
  }

  @override
  Widget build(BuildContext context) {
    final orderService = Provider.of<OrderService>(context, listen: false);
    final summaryService = Provider.of<SummaryService>(context, listen: false);

    return Scaffold(
        backgroundColor: DarkModePlatformTheme.black,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TextHeader(
                centerText: "",
                closeText: AppLocalizations.of(context)!.close,
                actionText: AppLocalizations.of(context)!.filter,
                actionFunction: () {
                  if (sellerId != orderService.sellerId ||
                      startDate != orderService.startDate ||
                      endDate != orderService.endDate) {
                    orderService.updateEndDate(value: endDate);
                    orderService.updateStartDate(value: startDate);
                    orderService.updateSellerId(value: sellerId);
                    orderService.resetOrder();
                    orderService.refreshOrder();
                    summaryService.resetSummary();
                    summaryService.fetchSummary(
                      startDate: startDate,
                      endDate: endDate,
                      sellerId: sellerId,
                    );
                    if (orderService.refreshController != null) {
                      orderService.refreshController!.resetNoData();
                    }
                  }
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 12,
              ),
              SliderHeader(
                index: index,
                updateIndex: (int value) {
                  index = value;
                  setState(() {});
                },
                icon: "assets/icons/bold/userSquare.svg",
                text: AppLocalizations.of(context)!.employees,
                icon1: "assets/icons/bold/calendar.svg",
                text1: AppLocalizations.of(context)!.date,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: IndexedStack(
                    index: index,
                    children: [
                      Employees(
                        sellerId: sellerId,
                        updateSellerId: (seller) {
                          setState(() {
                            sellerId = seller;
                          });
                        },
                      ),
                      Calendar(
                        updateStartDate: (p0) {
                          setState(() {
                            startDate = p0;
                          });
                        },
                        updateEndDate: (p0) {
                          setState(() {
                            endDate = p0;
                          });
                        },
                        startDate: startDate,
                        endDate: endDate,
                        sellerId: sellerId,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
