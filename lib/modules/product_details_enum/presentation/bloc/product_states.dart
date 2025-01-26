import 'package:lean_architecture/base/bloc/base_states.dart';

import '../../../product_details/domain/entities/product.dart';

class ProductStates extends BaseState<Product> {
  const ProductStates._(
    super.state, {
    super.data,
    super.message,
  });

  factory ProductStates.idle() => const ProductStates._(BaseStateEnum.idle);
  factory ProductStates.loading() => const ProductStates._(BaseStateEnum.loading);
  factory ProductStates.empty() => const ProductStates._(BaseStateEnum.empty);
  factory ProductStates.success(Product product) => ProductStates._(
        BaseStateEnum.success,
        data: product,
      );
  factory ProductStates.error(String message) => ProductStates._(
        BaseStateEnum.error,
        message: message,
      );
}
