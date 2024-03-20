import 'package:lean_requester/repository_exp.dart';

import '../entities/product.dart';

abstract interface class ProductRepository {
  RepositoryResult<Product> getProductById(int id);
}
