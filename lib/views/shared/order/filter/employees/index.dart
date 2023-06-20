import 'package:adret/model/userSettings/index.dart';
import 'package:adret/services/user/index.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/widgets/card/horizontalCard/index.dart';
import 'package:adret/widgets/card/user/index.dart';
import 'package:adret/widgets/card/user/loading.dart';
import 'package:adret/widgets/dataFetcher/footer.dart';
import 'package:adret/widgets/dataFetcher/header.dart';
import 'package:adret/widgets/empty/index.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Employees extends StatefulWidget {
  final Function(String?) updateSellerId;
  final String? sellerId;
  const Employees({
    Key? key,
    this.sellerId,
    required this.updateSellerId,
  }) : super(key: key);
  static const routeName = '/employees';

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  late RefreshController _refreshController;
  late String companyId;
  bool errorLoading = false;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    fetchData();
    var hiveUserSetting = Hive.box<UserSettingModel>('userSetting');
    UserSettingModel userSetting =
        hiveUserSetting.get("current", defaultValue: UserSettingModel())!;
    companyId = userSetting.companyId ?? "";
  }

  fetchData() async {
    final userService = Provider.of<UserService>(context, listen: false);
    if (userService.users.isEmpty) {
      try {
        if (mounted && errorLoading) {
          setState(() {
            errorLoading = false;
          });
        }
        await userService.refreshUsers();
      } catch (e) {
        if (mounted) {
          setState(() {
            errorLoading = true;
          });
        }
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
    final userService = Provider.of<UserService>(context, listen: true);

    void onRefresh() async {
      try {
        await userService.refreshUsers();
        _refreshController.refreshCompleted();
      } catch (e) {
        _refreshController.refreshFailed();
      }
    }

    void onLoading() async {
      try {
        bool moreData = await userService.loadMoreUsers();
        if (!moreData) {
          _refreshController.loadNoData();
        } else {
          _refreshController.loadComplete();
        }
      } catch (e) {
        _refreshController.loadFailed();
      }
    }

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
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
                GestureDetector(
                  onTap: () {
                    widget.updateSellerId(null);
                  },
                  child: HorizontalCard(
                    active: widget.sellerId == null,
                    subText: companyId,
                    title: AppLocalizations.of(context)!.allEmployeesSales,
                    icon: "assets/icons/bold/shop.svg",
                    subTextSize: 14,
                    titleSize: 18,
                    titleFontWeight: FontWeight.w600,
                    subTextFontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          if (userService.users.isNotEmpty)
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 130,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: userService.users.length,
                (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      widget.updateSellerId(
                        userService.users[index].id,
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: UserCard(
                        active: widget.sellerId == userService.users[index].id,
                        title: userService.users[index].fullName ?? "",
                        subText: companyNameRemover(
                            userService.users[index].userName ?? "-"),
                      ),
                    ),
                  );
                },
              ),
            ),
          if (userService.loading)
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 130,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: 24,
                (BuildContext context, int index) {
                  return const UserLoadingCard();
                },
              ),
            ),
          if (userService.users.isEmpty &&
              !userService.loading &&
              !errorLoading)
            SliverList(
              delegate: SliverChildListDelegate([
                EmptyState(
                  topText: AppLocalizations.of(context)!.noUsers,
                  subText: AppLocalizations.of(context)!.noEmployee,
                  emptyIcon: "assets/icons/bold/users.svg",
                  height: 165,
                )
              ]),
            ),
          if (userService.users.isEmpty && !userService.loading && errorLoading)
            SliverList(
              delegate: SliverChildListDelegate([
                EmptyState(
                  action: () async {
                    fetchData();
                  },
                  emptyIcon: "assets/icons/warning.svg",
                  height: 150,
                  actionIcon: "assets/icons/bold/reload.svg",
                  actionText: "Retry",
                  subText:
                      "Something went wrong and could not fetch Employee's.",
                  topText: "Error Fetching Employee's",
                ),
              ]),
            ),
        ],
      ),
    );
  }
}
