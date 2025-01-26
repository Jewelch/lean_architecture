import 'package:lean_architecture/base/screens/exports.dart';

import '../../../../base/bloc/exports.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_by_id.dart';
import 'product_events.dart';
import 'product_states.dart';

abstract class ProductDetailsBloc extends BaseBloc<ProductEvent, ProductState> {
  ProductDetailsBloc(super.initialState);

  loadProduct<T extends ProductEvent>(T event, Emitter<ProductState> emit);
  clearProduct<T extends ProductEvent>(T event, Emitter<ProductState> emit);
}

final class ProductDetailsBlocImpl extends ProductDetailsBloc {
  GetProductByIdUC get getProductById => get<GetProductByIdUC>();

  ProductDetailsBlocImpl() : super(Idle()) {
    on<GetProduct>(loadProduct<GetProduct>);
    on<ClearProduct>(clearProduct<ClearProduct>);
  }

  @override
  void onInit() {
    super.onInit();
    Debugger.magenta("onInit");
  }

  @override
  void onReady() {
    super.onReady();
    Debugger.magenta("onReady");
  }

  @override
  void onClose() {
    Debugger.magenta("onClose");
    super.onClose();
  }

  @override
  loadProduct<T extends ProductEvent>(T event, Emitter<ProductState> emit) async {
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
  clearProduct<T extends ProductEvent>(T event, Emitter<ProductState> emit) {
    emit(Idle());
  }
}
