import 'package:lean_requester/usecase_exp.dart';

import '../../../product_details/domain/entities/product.dart';
import '../repository/products_repository.dart';

final class GetProductsUC implements UseCase<List<Product>, NoParams> {
  final ProductsRepository productsRepository;

  const GetProductsUC(this.productsRepository);

  @override
  UsecaseResult<List<Product>?> call(NoParams params) async => await productsRepository.getProducts();
}
