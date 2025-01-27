import '../../../../../base/screens/exports.dart';
import '../../../common/presentation/widgets/clear_button.dart';
import '../../dependencies/product_screen_deps.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_events.dart';
import '../bloc/product_states.dart';

final class ProductDetailsScreen extends BlocProviderWidget<ProductDetailsBlocClasses> {
  ProductDetailsScreen({super.key})
      : super(
          dependencies: ProductScreenDependencies(),
        );

  @override
  Widget build(BuildContext context) => SmartScaffold(
        bottomBarParent: BottomBarParents.product,
        title: 'Product details (Classes)',
        body: BlocBuilder<ProductDetailsBlocClasses, ProductState>(
          builder: (context, state) => switch (state) {
            Idle() => TextFormField(controller: bloc.textEditingController).center().overallPadding(),
            Loading() => const CircularProgressIndicator(strokeWidth: 1).squared(20).center(),
            Error() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message).center(),
                  ClearButton<ProductDetailsBlocClasses>().customPadding(top: 16),
                ],
              ),
            Empty() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No data").center(),
                  ClearButton<ProductDetailsBlocClasses>().customPadding(top: 16),
                ],
              ),
            //? Pattern matching
            Success(product: final product) => Column(
                children: [
                  ProductCard(product).customPadding(bottom: 20, top: 50),
                  ClearButton<ProductDetailsBlocClasses>(),
                ],
              ),
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
          child: const Text("Get product"),
          onPressed: () => bloc.add(GetProduct(bloc.textEditingController.text)),
        ).resize(width: 200, height: 45),
      );
}
