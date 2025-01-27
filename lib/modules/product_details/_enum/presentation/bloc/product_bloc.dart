import 'package:lean_architecture/base/screens/exports.dart';

import '../../../../../base/bloc/exports.dart';
import '../../../common/domain/usecases/get_product_by_id.dart';
import 'product_events.dart';
import 'product_states.dart';

final class ProductDetailsBlocEnum extends BaseBloc<ProductEvent, ProductStates> {
  ProductDetailsBlocEnum() : super(ProductStates.idle()) {
    on<GetProduct>(loadProduct);
    on<ClearProduct>(clearProduct);
  }

  final getProductById = get<GetProductByIdUC>();

  final textEditingController = TextEditingController();

  loadProduct(GetProduct event, Emitter<ProductStates> emit) async {
    emit(ProductStates.loading());

    final result = await getProductById.call(Params(id: event.id));

    result.fold(
      (failure) => emit(ProductStates.error(failure.toString())),
      (product) => emit(product.isEmpty ? ProductStates.empty() : ProductStates.success(product)),
    );
  }

  clearProduct(ClearProduct event, Emitter<ProductStates> emit) => emit(ProductStates.idle());

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
