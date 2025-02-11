import '../../../../../base/bloc/exports.dart';
import '../../../common/entities/product.dart';
import '../../domain/usecases/get_products.dart';
import 'products_events.dart';
import 'products_states.dart';

final class ProductsBloc extends BaseBloc<ProductEvent, ProductState> {
  final GetProductsUC getProductById;

  ProductsBloc(this.getProductById) : super(Idle()) {
    on<GetProducts>(_loadProducts);
    on<ClearProducts>(_clearProducts);
  }

  void _loadProducts(GetProducts event, Emitter<ProductState> emit) async {
    emit(Loading());

    await getProductById.call(NoParams()).then(
          (result) => result.fold(
            (failure) => emit(
              Error(message: failure.message),
            ),
            (List<Product>? products) => products == null
                ? emit(Empty())
                : emit(
                    Success(products: products),
                  ),
          ),
        );
  }

  void _clearProducts(ClearProducts event, Emitter<ProductState> emit) {
    emit(Idle());
  }
}
