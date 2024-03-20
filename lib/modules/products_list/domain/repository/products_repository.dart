import 'package:lean_requester/repository_exp.dart';

import '../../../product_details/domain/entities/product.dart';

abstract interface class ProductsRepository {
  RepositoryResult<List<Product>?> getProducts();
}
