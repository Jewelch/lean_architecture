import 'package:lean_requester/usecase_exp.dart';

import '../entities/product.dart';
import '../repository/product_repository.dart';

class GetProductByIdUC implements UseCase<Product, Params> {
  final ProductRepository productsRepository;

  const GetProductByIdUC(this.productsRepository);

  @override
  UsecaseResult<Product> call(Params params) async => await productsRepository.getProductById(params.id);
}

final class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
