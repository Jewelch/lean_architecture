import '../../../../api/data_source.dart';
import '../../../product_details/data/models/product_model.dart';

abstract interface class ProductsRemoteDataSource {
  /// Calls the https://dummyjson.com/products endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>?> getProducts();
}

final class ProductsRemoteDataSourceImpl extends LeanRequesterConfig implements ProductsRemoteDataSource {
  ProductsRemoteDataSourceImpl({required Dio client}) : super(client);

  @override
  Future<List<ProductModel>?> getProducts() async {
    const bool keyedList = true;
    try {
      return (await performDecodingRequest(
        path: "products",
        method: RestfullMethods.get,
        dao: ProductModel(),
        asList: true,
        listKey: keyedList ? "products" : null,
        mockIt: true,
        mockingData: keyedList ? {"products": productsMap} : productsMap,
      ) as DaoList<ProductModel>)
          .list;
    } catch (_) {
      throw ServerException();
    }
  }
}

const productsMap = [
  {
    "id": 1,
    "title": "iPhone 9",
    "description": "An apple mobile which is nothing like apple",
    "price": 549,
    "discountPercentage": 12.96,
    "rating": 4.69,
    "stock": 94,
    "brand": "Apple",
    "category": "smartphones",
    "thumbnail": "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
    "images": [
      "https://cdn.dummyjson.com/product-images/1/1.jpg",
      "https://cdn.dummyjson.com/product-images/1/2.jpg",
      "https://cdn.dummyjson.com/product-images/1/3.jpg",
      "https://cdn.dummyjson.com/product-images/1/4.jpg",
      "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"
    ]
  },
  {
    "id": 2,
    "title": "iPhone X",
    "description": "SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip with ...",
    "price": 899,
    "discountPercentage": 17.94,
    "rating": 4.44,
    "stock": 34,
    "brand": "Apple",
    "category": "smartphones",
    "thumbnail": "https://cdn.dummyjson.com/product-images/2/thumbnail.jpg",
    "images": [
      "https://cdn.dummyjson.com/product-images/2/1.jpg",
      "https://cdn.dummyjson.com/product-images/2/2.jpg",
      "https://cdn.dummyjson.com/product-images/2/3.jpg",
      "https://cdn.dummyjson.com/product-images/2/thumbnail.jpg"
    ]
  },
];
