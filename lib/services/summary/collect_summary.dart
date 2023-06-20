import 'package:adret/client.dart';
import 'package:adret/graphql/summary.dart';
import 'package:adret/model/summary/index.dart';
import 'package:adret/utils/convert/summary_convertor.dart';
import 'package:graphql/client.dart';

Future<dynamic> collectSummaryFunction({
  required String id,
}) async {
  try {
    final QueryResult result = await Config.initializeClient().mutate(
      MutationOptions(
          document: gql(SummaryGraphql.collectSummary),
          variables: {"managerAcceptId": id}),
    );
    if (result.exception != null) {
      throw Exception(result.exception);
    } else if (result.data != null) {
      SummaryModel sale = summaryConverter(data: result.data!["managerAccept"]);
      return sale;
    }
  } catch (e) {
    throw Exception(e);
  }
}
