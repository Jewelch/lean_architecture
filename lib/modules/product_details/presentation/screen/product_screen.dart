import '../../../../base/screens/exports.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_events.dart';
import '../bloc/product_states.dart';
import '../dependencies/product_screen_deps.dart';

final class ProductDetailsScreen extends FullBlocProvidingWidget<ProductDetailsBlocImpl> {
  ProductDetailsScreen({super.key}) : super(dependencies: ProductScreenDependencies());

  @override
  Widget build(BuildContext context) => SmartScaffold(
        bottomBarParent: BottomBarParents.product,
        title: 'Product details',
        body: BlocBuilder<ProductDetailsBlocImpl, ProductState>(
          builder: (context, state) => switch (state) {
            Idle() => TextFormField(
                controller: bloc.textEditingController,
              ),
            Loading() => const CircularProgressIndicator(strokeWidth: 1).squared(20).center(),
            Error() => Text(state.message),
            Empty() => const SizedBox.shrink(),
            //? Pattern matching
            Success(product: final product) => Column(
                children: [
                  ProductCard(product).customPadding(bottom: 20, top: 50),
                  ElevatedButton(
                    child: const Text("Clear"),
                    onPressed: () => bloc.add(ClearProduct()),
                  ).resize(width: 100, height: 45),
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
