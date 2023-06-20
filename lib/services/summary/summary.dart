import 'package:adret/client.dart';
import 'package:adret/graphql/summary.dart';
import 'package:adret/model/summary/index.dart';
import 'package:adret/utils/convert/summary_convertor.dart';
import 'package:graphql/client.dart';

Future<dynamic> fetchSummaryFunction({
  required String startDate,
  required String endDate,
}) async {
  try {
    final QueryResult result = await Config.initializeClient().query(
      QueryOptions(document: gql(SummaryGraphql.summary), variables: {
        "startDate": startDate,
        "endDate": endDate,
      }),
    );

    if (result.exception != null) {
      throw Exception(result.exception);
    } else if (result.data != null) {
      SummaryModel sale = summaryConverter(data: result.data!["summary"]);
      return sale;
    }
  } catch (e) {
    throw Exception(e);
  }
}
