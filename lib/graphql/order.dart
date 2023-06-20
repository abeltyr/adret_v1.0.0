class OrderGraphql {
  static String order = r'''
    query Order($orderId: ID!) {
      order(id: $orderId) {
        id
        online
        orderNumber
        note
        totalPrice
        totalProfit
        date
        seller {
          fullName
          userName
          id
        }
        createdAt
        updatedAt
        deletedAt
        sales {
            sellingPrice
            profit
            inventory {
              id
              inventoryVariation {
                data
                title
              }
              media
              salesAmount
              available
              product {
                productCode
                title
              }
            }
        }
      }
    }
  ''';

  static String orders = r'''
    query Query($input: ordersFilter!) {
      orders(input: $input) {
        id
        online
        orderNumber
        note
        totalPrice
        totalProfit
        date
        seller {
          fullName
          userName
          id
        }
        createdAt
        updatedAt
        deletedAt
        sales {
            sellingPrice
            profit
            inventory {
              id
              inventoryVariation {
                data
                title
              }
              media
              salesAmount
              available
              product {
                productCode
                title
              }
            }
        }
      }
    }
  ''';

  static String createOrder = r'''
      mutation Mutation($input: createLocalOrderInput!) {
        createLocalOrder(input: $input) {
          id
          online
          orderNumber
          note
          totalPrice
          totalProfit
          date
          seller {
            fullName
            userName
            id
          }
          createdAt
          updatedAt
          deletedAt
          sales {
            sellingPrice
            profit
            inventory {
              id
              inventoryVariation {
                data
                title
              }
              media
              salesAmount
              available
              product {
                productCode
                title
              }
            }
          }
        }
      }
  ''';
}
