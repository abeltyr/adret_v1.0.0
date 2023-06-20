import 'package:adret/model/user/index.dart';
import 'package:adret/utils/role.dart';
import 'package:adret/widgets/card/summary/employee/index.dart';
import 'package:adret/widgets/card/summary/manger/index.dart';
import 'package:adret/widgets/card/summary/top/index.dart';
import 'package:flutter/cupertino.dart';

class SummaryCard extends StatelessWidget {
  final String userRole;
  final String sales;
  final String profit;
  final String date;
  final String? secondDate;
  final bool collected;
  final UserModel? employee;
  final Function onClick;
  const SummaryCard({
    super.key,
    this.userRole = "Employee",
    required this.sales,
    required this.profit,
    required this.date,
    this.secondDate,
    required this.collected,
    required this.employee,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 30),
      child: Column(
        children: [
          if (isManager(userRole))
            SummaryTopCard(
              date: date,
              secondDate: secondDate,
              employee: employee,
            ),
          if (isManager(userRole))
            const SizedBox(
              height: 10,
            ),
          if (isManager(userRole))
            ManagerSummaryCard(
              collected: collected,
              date: date,
              employee: employee,
              onClick: onClick,
              profit: profit,
              sales: sales,
            )
          else
            EmployeeSummaryCard(
              collected: collected,
              date: date,
              employee: employee,
              onClick: onClick,
              profit: profit,
              sales: sales,
            ),
        ],
      ),
    );
  }
}
