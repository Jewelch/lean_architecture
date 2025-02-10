import '../../../../../base/bloc/exports.dart';
import '../../domain/usecases/get_product_by_id.dart';
import 'product_events.dart';
import 'product_states.dart';

final class ProductDetailsBloc extends BaseBloc<ProductEvent, ProductState> {
  final textEditingController = TextEditingController();

  final getProductById = get<GetProductByIdUC>();

  ProductDetailsBloc() : super(Idle()) {
    on<GetProduct>(loadProduct);
    on<ClearProduct>(clearProduct);
  }

  loadProduct(GetProduct event, Emitter<ProductState> emit) async {
    emit(Loading());

    final result = await getProductById.call(Params(id: textEditingController.text));

    result.fold(
      (failure) => emit(Error(message: failure.message)),
      (product) => product.isEmpty
          ? emit(Empty())
          : emit(
              Success(product: product),
            ),
    );
  }

  clearProduct(ClearProduct event, Emitter<ProductState> emit) => emit(Idle());

  @override
  void onDispose() {
    textEditingController.dispose();
    super.onDispose();
  }
}
