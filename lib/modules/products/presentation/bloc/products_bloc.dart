import 'package:bloc/bloc.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_by_id.dart';
import 'product_events.dart';
import 'product_states.dart';

final class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductByIdUC getProductById;

  ProductBloc(this.getProductById) : super(Idle()) {
    on<GetProduct>(_loadProducts);
    on<ClearProduct>(_clearProducts);
  }

  void _loadProducts(GetProduct event, Emitter<ProductState> emit) async {
    emit(Loading());

    await getProductById.call(Params(id: event.id)).then(
          (value) => value.fold(
            (failure) => emit(
              Error(message: failure.toString()),
            ),
            (Product? product) => emit(
              product == null ? Empty() : Success(product: product),
            ),
          ),
        );
  }

  void _clearProducts(ClearProduct event, Emitter<ProductState> emit) {
    emit(Idle());
  }
}
