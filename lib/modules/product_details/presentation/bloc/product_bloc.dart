import '../../../../base/bloc/exports.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_by_id.dart';
import 'product_events.dart';
import 'product_states.dart';

abstract class ProductDetailsBloc extends Bloc<ProductEvent, ProductState> {
  ProductDetailsBloc(super.initialState);

  loadProductDetails<T extends ProductEvent>(T event, Emitter<ProductState> emit);
  clearProductDetails<T extends ProductEvent>(T event, Emitter<ProductState> emit);
  treatHachwa<T extends ProductEvent>(T event, Emitter<ProductState> emit);
}

final class ProductDetailsBlocImpl extends ProductDetailsBloc {
  final GetProductByIdUC getProductById;

  ProductDetailsBlocImpl(this.getProductById) : super(Idle()) {
    on<GetProduct>(loadProductDetails<GetProduct>);
    on<ClearProduct>(clearProductDetails<ClearProduct>);
    on<Hachwa>(treatHachwa<Hachwa>);
  }

  @override
  loadProductDetails<T extends ProductEvent>(T event, Emitter<ProductState> emit) async {
    emit(Loading());

    await getProductById.call(Params(id: (event as GetProduct).id)).then(
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

  @override
  clearProductDetails<T extends ProductEvent>(T event, Emitter<ProductState> emit) {
    emit(Idle());
  }

  @override
  treatHachwa<T extends ProductEvent>(T event, Emitter<ProductState> emit) {
    emit(Idle());
  }
}
