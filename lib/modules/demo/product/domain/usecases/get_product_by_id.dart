import 'package:lean_requester/lean_requester.dart';

import '../../../common/entities/product.dart';
import '../../../common/models/product_model.dart';
import '../../data/datasource/product_datasource.dart';

class GetProductByIdUC extends SingleResultUseCase<Product, ProductModel, Params> {
  GetProductByIdUC(ProductDataSource dataSource)
      : super(
          dataSourceEntry: (params) => dataSource.getProductById(params.id),
          modelToEntityMapper: Product.from,
        );
}

final class Params extends Equatable {
  final String id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
