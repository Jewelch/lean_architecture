import 'package:lean_architecture/base/screens/exports.dart';

import '../../../../../base/bloc/exports.dart';
import '../../../common/domain/usecases/get_product_by_id.dart';
import 'product_events.dart';
import 'product_states.dart';

final class ProductDetailsBlocClasses extends BaseBloc<ProductEvent, ProductState> {
  final textEditingController = TextEditingController();

  final getProductById = get<GetProductByIdUC>();

  ProductDetailsBlocClasses() : super(Idle()) {
    on<GetProduct>(loadProduct);
    on<ClearProduct>(clearProduct);
  }

  loadProduct(GetProduct event, Emitter<ProductState> emit) async {
    emit(Loading());

    final result = await getProductById.call(Params(id: event.id));

    result.fold(
      (failure) => emit(Error(message: failure.toString())),
      (product) => emit(product.isEmpty ? Empty() : Success(product: product)),
    );
  }

  clearProduct(ClearProduct event, Emitter<ProductState> emit) => emit(Idle());

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
