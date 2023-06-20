import 'package:adret/model/userSettings/index.dart';
import 'package:adret/services/user/index.dart';
import 'package:adret/utils/text.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/views/shared/account/employeeSetup/addEmployee/index.dart';
import 'package:adret/views/shared/account/employeeSetup/setting/index.dart';
import 'package:adret/widgets/card/user/index.dart';
import 'package:adret/widgets/card/user/loading.dart';
import 'package:adret/widgets/dataFetcher/footer.dart';
import 'package:adret/widgets/dataFetcher/header.dart';
import 'package:adret/widgets/empty/index.dart';
import 'package:adret/widgets/header/displayHeader/index.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeeSetupScreen extends StatefulWidget {
  static const routeName = '/employeeSetup';
  const EmployeeSetupScreen({super.key});

  @override
  State<EmployeeSetupScreen> createState() => _EmployeeSetupScreenState();
}

class _EmployeeSetupScreenState extends State<EmployeeSetupScreen> {
  late RefreshController _refreshController;
  late String companyId;

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
        await userService.refreshUsers();
        // ignore: empty_catches
      } catch (e) {}
    }
  }

  void onRefresh() async {
    try {
      final userService = Provider.of<UserService>(context, listen: false);

      await userService.refreshUsers();
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  void onLoading() async {
    try {
      final userService = Provider.of<UserService>(context, listen: false);
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

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: true);

    return Scaffold(
      backgroundColor: DarkModePlatformTheme.secondBlack,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 15,
          right: 15,
        ),
        child: Column(
          children: [
            DisplayHeader(
              // centerText: "",
              // actionText: "done",
              // actionFunction: () {
              //   Navigator.pop(context);
              // },
              title: AppLocalizations.of(context)!.employees,
              size: 22,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              icon: !userService.loading && userService.users.length < 3
                  ? "assets/icons/bold/addUser.svg"
                  : null,
              iconAction: () {
                if (!userService.loading && userService.users.length < 3) {
                  showCupertinoModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (context) => const AddEmployee(),
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SmartRefresher(
                enablePullDown: true && !userService.loading,
                enablePullUp: true && !userService.loading,
                header: const DataFetcherHeader(),
                footer: const DataFetcherFooter(),
                controller: _refreshController,
                onRefresh: onRefresh,
                onLoading: onLoading,
                child: CustomScrollView(slivers: [
                  if (userService.loading)
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width / 4,
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
                  if (userService.users.isNotEmpty && !userService.loading)
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width / 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 130,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: userService.users.length,
                        (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              showCupertinoModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0),
                                  ),
                                ),
                                context: context,
                                builder: (context) => EmployeeSettings(
                                  userIndex: index,
                                ),
                              );
                            },
                            child: UserCard(
                              active: false,
                              subText: companyNameRemover(
                                  userService.users[index].userName!),
                              title: userService.users[index].fullName!,
                            ),
                          );
                        },
                      ),
                    ),
                  if (!userService.loading && userService.users.isEmpty)
                    SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(
                          height: 100,
                        ),
                        EmptyState(
                          action: () {
                            showCupertinoModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
                              context: context,
                              builder: (context) => const AddEmployee(),
                            );
                          },
                          actionIcon: "assets/icons/bold/addUser.svg",
                          emptyIcon: "assets/icons/bold/people.svg",
                          actionText: AppLocalizations.of(context)!.addEmployee,
                          subText: AppLocalizations.of(context)!
                              .addEmployeeButtonText,
                          topText: AppLocalizations.of(context)!.noEmployee,
                        )
                      ]),
                    ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
