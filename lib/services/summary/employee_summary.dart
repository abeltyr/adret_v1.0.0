import 'package:adret/client.dart';
import 'package:adret/graphql/summary.dart';
import 'package:adret/model/summary/index.dart';
import 'package:adret/utils/convert/summary_convertor.dart';
import 'package:graphql/client.dart';

Future<dynamic> fetchEmploySummaryFunction({
  required String date,
  required String employeeId,
}) async {
  try {
    final QueryResult result = await Config.initializeClient().query(
      QueryOptions(
          document: gql(SummaryGraphql.employeeDailySummary),
          variables: {
            "input": {"date": date, "employeeId": employeeId}
          }),
    );

    if (result.exception != null) {
      throw Exception(result.exception);
    } else if (result.data != null) {
      SummaryModel sale =
          summaryConverter(data: result.data!["employeeDailySummary"]);
      return sale;
    }
  } catch (e) {
    throw Exception(e);
  }
}
