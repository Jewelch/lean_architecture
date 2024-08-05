import '../../../../api/data_source.dart';
import '../../../product_details/data/models/product_model.dart';

abstract interface class ProductsDataSource {
  /// Calls the https://dummyjson.com/products endpoint.
  Future<List<ProductModel>> getProducts();
}

final class ProductsDataSourceImpl extends LeanRequesterConfig implements ProductsDataSource {
  ProductsDataSourceImpl({
    required Dio client,
    required CacheManager cacheManager,
    required ConnectivityMonitor connectivityMonitor,
  }) : super(client, cacheManager, connectivityMonitor);

  @override
  Future<List<ProductModel>> getProducts() async {
    return (await performDecodingRequest(
          // mockingEnabled: true,
          cachingKey: 'productsKey',
          path: "products",
          method: RestfullMethods.get,
          dao: ProductModel(),
          asList: true,
          listKey: "products",
          mockingData: true ? {"products": productsMap} : productsMap,
        ) as DaoList<ProductModel>)
            .list ??
        [];
  }
}

const productsMap = [
  {
    "id": 1,
    "title": "iPhone de Hadil",
    "description": "An apple mobile which is nothing like apple",
    "price": 549,
    "discountPercentage": 12.96,
    "rating": 4.69,
    "stock": 94,
    "brand": "Apple",
    "category": "smartphones",
    "thumbnail":
        "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-card-40-iphone15prohero-202309_FMT_WHH?wid=508&hei=472&fmt=p-jpg&qlt=95&.v=1693086369818",
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
    "thumbnail": "https://www.istore.com.tn/4701-medium_default/iphone-14-128-go-blue.jpg",
    "images": [
      "https://cdn.dummyjson.com/product-images/2/1.jpg",
      "https://cdn.dummyjson.com/product-images/2/2.jpg",
      "https://cdn.dummyjson.com/product-images/2/3.jpg",
      "https://cdn.dummyjson.com/product-images/2/thumbnail.jpg"
    ]
  },
];
