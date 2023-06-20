class ProductGraphql {
  static String product = r'''
      query Product($productId: ID!) {
        product(id: $productId) {
          id
          productCode
          title
          detail
          category
          creator {
            id
            fullName
            userName
            userRole
          }
          inStock
          createdAt
          updatedAt
          deletedAt
          media 
          inventory {
            media 
            available
            id
            initialPrice
            inventoryVariation {
              data
              title
            }
            salesAmount
            minSellingPriceEstimation
            maxSellingPriceEstimation
          }
        }
      }
  ''';

  static String productByCode = r'''
    query ProductByCode($productCode: String!) {
      productByCode(productCode: $productCode) {
        id
        productCode
        title
        detail
        category
        creator {
          id
          fullName
          userName
          userRole
        }
        inStock
        createdAt
        updatedAt
        deletedAt
        media 
        inventory {
          media 
          available
          id
          initialPrice
          inventoryVariation {
            data
            title
          }
          salesAmount
          minSellingPriceEstimation
          maxSellingPriceEstimation
        }
      }
    }
  ''';

  static String products = r'''
    query Products($input: productsFilter!) {
      products(input: $input) {
        id
        productCode
        title
        detail
        creator {
          id
          fullName
          userName
          userRole
        }
        inStock
        category
        media
        inventory {
          id
          media
          available
          salesAmount
          initialPrice
          minSellingPriceEstimation
          maxSellingPriceEstimation
          inventoryVariation {
            data
            title
          }
        }
      }
    }
  ''';

  static String createProduct = r'''
    mutation CreateProduct($input: createProductInput!) {
      createProduct(input: $input) {
        id
        productCode
        title
        detail
        category
        createdAt
        updatedAt
        deletedAt
        media
        inStock
        inventory {
          id
          media
          available
          salesAmount
          initialPrice
          minSellingPriceEstimation
          maxSellingPriceEstimation
          inventoryVariation {
            data
            title
          }
        }
      }
    }
  ''';

  static String updateProduct = r'''
    mutation UpdateProduct($input: updateProductInput!) {
      updateProduct(input: $input) {
        id
        productCode
        title
        detail
        category
        createdAt
        updatedAt
        deletedAt
        media
        inStock
        inventory {
          id
          media
          available
          salesAmount
          initialPrice
          minSellingPriceEstimation
          maxSellingPriceEstimation
          inventoryVariation {
            data
            title
          }
        }
      }
    }
  ''';
}
