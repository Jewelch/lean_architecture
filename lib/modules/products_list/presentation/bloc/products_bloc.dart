import 'package:bloc/bloc.dart';
import 'package:lean_requester/lean_interceptor.dart';

import '../../../product_details/domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';
import 'products_events.dart';
import 'products_states.dart';

final class ProductsBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUC getProductById;

  ProductsBloc(this.getProductById) : super(Idle()) {
    on<GetProducts>(_loadProducts);
    on<ClearProducts>(_clearProducts);
  }

  void _loadProducts(GetProducts event, Emitter<ProductState> emit) async {
    emit(Loading());

    await getProductById.call(NoParams()).then(
          (value) => value.fold(
            (failure) => emit(
              Error(message: failure.toString()),
            ),
            (List<Product>? products) => emit(
              products == null ? Empty() : Success(products: products),
            ),
          ),
        );
  }

  void _clearProducts(ClearProducts event, Emitter<ProductState> emit) {
    emit(Idle());
  }
}
