import 'package:lean_requester/lean_requester.dart';

import '../../../common/data_models/product_model.dart';
import '../../../common/domain_entities/product.dart';
import '../../data/definition/product_datasource.dart';

class GetProductByIdUC extends UseCase<Product, ProductModel, Product> {
  GetProductByIdUC(ProductDataSource dataSource)
      : super(
          dataSourceFetcher: (params) => dataSource.getProductById(params.id),
          modelToEntityMapper: Product.from,
        );
}

final class Params extends Equatable {
  final String id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
