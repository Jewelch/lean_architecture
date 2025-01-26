import 'package:lean_architecture/base/screens/exports.dart';

import '../../../../base/bloc/exports.dart';
import '../../../product_details/domain/entities/product.dart';
import '../../../product_details/domain/usecases/get_product_by_id.dart';
import 'product_events.dart';
import 'product_states.dart';

abstract class ProductDetailsBloc extends BaseBloc<ProductEvent, ProductStates> {
  ProductDetailsBloc(super.initialState);

  loadProduct<T extends ProductEvent>(T event, Emitter<ProductStates> emit);
  clearProduct<T extends ProductEvent>(T event, Emitter<ProductStates> emit);
}

final class ProductDetailsBlocEnum extends ProductDetailsBloc {
  GetProductByIdUC get getProductById => get<GetProductByIdUC>();

  ProductDetailsBlocEnum() : super(ProductStates.idle()) {
    on<GetProduct>(loadProduct<GetProduct>);
    on<ClearProduct>(clearProduct<ClearProduct>);
    textEditingController = TextEditingController();
  }

  late TextEditingController textEditingController;

  @override
  void onInit() {
    textEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  @override
  loadProduct<T extends ProductEvent>(T event, Emitter<ProductStates> emit) async {
    emit(ProductStates.loading());

    await getProductById.call(Params(id: (event as GetProduct).id)).then(
          (value) => value.fold(
            (failure) => emit(
              ProductStates.error(failure.toString()),
            ),
            (Product? product) => emit(
              product == null ? ProductStates.empty() : ProductStates.success(product),
            ),
          ),
        );
  }

  @override
  clearProduct<T extends ProductEvent>(T event, Emitter<ProductStates> emit) {
    emit(ProductStates.idle());
  }
}
