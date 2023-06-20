import 'package:adret/services/orders/index.dart';
import 'package:adret/services/summary/index.dart';
import 'package:adret/services/user/index.dart';
import 'package:adret/utils/role.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/views/shared/checkout/index.dart';
import 'package:adret/views/shared/order/order/empty.dart';
import 'package:adret/views/shared/order/order/error.dart';
import 'package:adret/views/shared/order/order/loading.dart';
import 'package:adret/views/shared/order/filter/index.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:adret/widgets/card/orderCard/index.dart';
import 'package:adret/widgets/card/summary/index.dart';
import 'package:adret/widgets/card/summaryLoading/index.dart';
import 'package:adret/widgets/dataFetcher/footer.dart';
import 'package:adret/widgets/dataFetcher/header.dart';
import 'package:adret/widgets/header/screenHeader/index.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late RefreshController _refreshController;
  bool errorLoading = false;

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);
    fetchData();
    super.initState();
  }

  fetchData() async {
    final orderService = Provider.of<OrderService>(context, listen: false);
    final summary = Provider.of<SummaryService>(context, listen: false);

    if (orderService.refreshController == null) {
      orderService.setRefreshController(_refreshController);
    }
    try {
      if (mounted && errorLoading) {
        setState(() {
          errorLoading = false;
        });
      }
      summary.fetchSummary(
        startDate: orderService.startDate,
        endDate: orderService.endDate,
        sellerId: orderService.sellerId,
      );
      await orderService.refreshOrder();
    } catch (e) {
      if (mounted) {
        setState(() {
          errorLoading = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderService = Provider.of<OrderService>(context, listen: true);
    final userService = Provider.of<UserService>(context, listen: true);
    final summaryService = Provider.of<SummaryService>(context, listen: true);

    void onRefresh() async {
      try {
        await orderService.refreshOrder();
        await summaryService.fetchSummary(
          startDate: orderService.startDate,
          endDate: orderService.endDate,
          sellerId: orderService.sellerId,
        );
        _refreshController.refreshCompleted();
      } catch (e) {
        _refreshController.refreshFailed();
      }
    }

    void onLoading() async {
      try {
        bool moreData = await orderService.loadMoreOrder();
        if (!moreData) {
          _refreshController.loadNoData();
        } else {
          _refreshController.loadComplete();
        }
      } catch (e) {
        _refreshController.loadFailed();
      }
    }

    String? startDate = summaryService.summary.startDate;
    String? endDate = summaryService.summary.endDate;

    if (summaryService.summary.date != null) {
      startDate = summaryService.summary.date;
      endDate = null;
    }
    return Stack(
      children: [
        Column(
          children: [
            ScreenHeader(
              icon: isManager(userService.currentUser.userRole ?? "")
                  ? "assets/icons/bold/filter.svg"
                  : null,
              title: isManager(userService.currentUser.userRole ?? "")
                  ? AppLocalizations.of(context)!.summary
                  : AppLocalizations.of(context)!.dailySummary,
              iconAction: isManager(userService.currentUser.userRole ?? "")
                  ? () {
                      showCupertinoModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        context: context,
                        enableDrag: false,
                        builder: (context) => const SalesFilter(),
                      );
                    }
                  : null,
            ),
            Expanded(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: orderService.orders.isNotEmpty,
                header: const DataFetcherHeader(),
                footer: const DataFetcherFooter(),
                controller: _refreshController,
                onRefresh: onRefresh,
                onLoading: onLoading,
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          const SizedBox(
                            height: 16,
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            reverseDuration: const Duration(milliseconds: 500),
                            child: !summaryService.loading
                                ? SummaryCard(
                                    sales:
                                        summaryService.summary.earning ?? "0",
                                    profit:
                                        summaryService.summary.profit ?? "0",
                                    date:
                                        startDate ?? DateTime.now().toString(),
                                    secondDate: endDate,
                                    collected: summaryService
                                            .summary.managerAccepted ??
                                        false,
                                    onClick: () async {
                                      await summaryService.collectSummary();
                                    },
                                    employee: summaryService.summary.employee,
                                    userRole:
                                        userService.currentUser.userRole ??
                                            "Employee",
                                  )
                                : SummaryCardLoading(
                                    showButton: orderService.sellerId != null,
                                    isManger: isManager(
                                        userService.currentUser.userRole ?? ""),
                                  ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: orderService.orders.length,
                        (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: OrderCard(
                              order: orderService.orders[index],
                            ),
                          );
                        },
                      ),
                    ),
                    if (errorLoading &&
                        orderService.orders.isEmpty &&
                        !orderService.loading)
                      OrderError(
                        onRetry: () async {
                          await fetchData();
                        },
                      ),
                    if (orderService.loading && orderService.orders.isEmpty)
                      const OrderLoading(),
                    if (!orderService.loading &&
                        orderService.orders.isEmpty &&
                        !errorLoading)
                      const OrderEmpty(),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
        Positioned(
          bottom: 96,
          right: 0,
          child: Row(
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: MainButton(
                  icon: "assets/icons/bold/cart.svg",
                  textFontSize: 30,
                  borderRadiusData: 10,
                  color: DarkModePlatformTheme.primary,
                  onClick: () {
                    CupertinoScaffold.showCupertinoModalBottomSheet(
                      context: context,
                      enableDrag: false,
                      builder: (context) => const CheckoutScreen(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
