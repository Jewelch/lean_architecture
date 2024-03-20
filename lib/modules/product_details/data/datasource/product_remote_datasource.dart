import '../../../../api/data_source.dart';
import '../models/product_model.dart';

abstract interface class ProductRemoteDataSource {
  /// Calls the https://dummyjson.com/products/{id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> getProductById(int id);
}

final class ProductRemoteDataSourceImpl extends LeanRequesterConfig implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({required Dio client}) : super(client);

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      return await performDecodingRequest(
        debugIt: true,
        path: "products/$id",
        method: RestfullMethods.get,
        dao: ProductModel(),
        mockIt: false,
        mockingData: {
          "id": 2,
          "title": "iPhone de Jewel",
          "description": "SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip with ...",
          "price": 899,
          "rating": 4.44,
          "stock": 34,
          "thumbnail": "https://i.dummyjson.com/data/products/2/thumbnail.jpg",
          "images": [
            "https://i.dummyjson.com/data/products/2/1.jpg",
            "https://i.dummyjson.com/data/products/2/2.jpg",
            "https://i.dummyjson.com/data/products/2/3.jpg",
          ]
        },
      );
    } catch (_) {
      throw ServerException();
    }
  }
}



















// final class ProductRemoteData {
//   final Dio client;

//   ProductRemoteData({required this.client});

//   Future<ProductModel> getProductById(int id, bool mockIt) async {
//     try {
//       // client.options = baseOptions ?? this.baseOptions;
//       // client.options.baseUrl = baseUrl ?? client.options.baseUrl;
//       // client.options.contentType = contentType?.mimeType ?? ContentType.json.mimeType;
//       // client.options.headers.addExtraHeaders(extraHeaders);

//       client.transformer = LeanTransformer(dao: ProductModel());
//       client.interceptors
//         ..clear()
//         ..add(QueuedInterceptorsWrapper(
//           onRequest: (options, handler) {
//             Debugger.red(options.path.toString());
//             handler.next(options);
//           },
//           onResponse: (response, handler) => handler.next(response),
//           onError: (error, handler) => handler.next(error),
//         ));
//       // ..add(AwesomeDioInterceptor(
//       //   logRequestHeaders: true,
//       //   logResponseHeaders: true,
//       //   logRequestTimeout: true,
//       // ));

//       final response = await client.get("products/$id");

//       if (mockIt) {
//         await Future.delayed(const Duration(milliseconds: 5000));

//         return ProductModel().fromJson({
//           "id": 2,
//           "title": "iPhone de Jewel",
//           "description": "SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip with ...",
//           "price": 899,
//           "rating": 4.44,
//           "stock": 34,
//           "thumbnail": "https://i.dummyjson.com/data/products/2/thumbnail.jpg",
//           "images": [
//             "https://i.dummyjson.com/data/products/2/1.jpg",
//             "https://i.dummyjson.com/data/products/2/2.jpg",
//             "https://i.dummyjson.com/data/products/2/3.jpg",
//           ]
//         });
//       } else
//         return ProductModel().fromJson(response);
//     } catch (_) {
//       throw ServerException();
//     }
//   }
// }
