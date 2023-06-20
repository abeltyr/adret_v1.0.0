class SummaryGraphql {
  static String collectSummary = r'''
      mutation ManagerAccept($managerAcceptId: ID!) {
        managerAccept(id: $managerAcceptId) {
          id
          earning
          profit
          managerAccepted
          manager {
            id
            userName
            fullName
          }
          employee {
            id
            userName
            fullName
          }
          date
          endDate
          startDate
          createdAt
          updatedAt
          deletedAt
        }
      }
  ''';

  static String summary = r'''
    query Query($startDate: Timestamp!, $endDate: Timestamp!) {
      summary(startDate: $startDate, endDate: $endDate) {
        id
        earning
        profit
        date
        endDate
        startDate
      }
    }
  ''';

  static String employeeDailySummary = r'''
    query EmployeeDailySummary($input: employeeDailySummaryFilter!) {
      employeeDailySummary(input: $input) {
        id
        earning
        profit
        managerAccepted
        manager {
          id
          userName
          fullName
        }
        employee {
          id
          userName
          fullName
        }
        date
        endDate
        startDate
      }
    }
  ''';
}
