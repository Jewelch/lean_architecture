import 'dart:math';

import '../../../../base/screens/exports.dart';
import '../../dependencies/product_screen_deps.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_events.dart';
import '../bloc/product_states.dart';

final class ProductDetailsScreen extends BaseScreen<ProductScreenDependencies, ProductDetailsBlocImpl> {
  ProductDetailsScreen({super.key}) : super(dependencies: ProductScreenDependencies());

  @override
  Widget build(BuildContext context) => BlocBuilder<ProductDetailsBlocImpl, ProductState>(
        builder: (context, state) => SmartScaffold(
          bottomBarParent: BottomBarParents.product,
          title: 'Product details',
          body: switch (state) {
            Idle() => const Text("Idle").center(),
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
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: ElevatedButton(
            child: const Text("Get product"),
            onPressed: () => bloc.add(GetProduct(Random().nextInt(20))),
          ).resize(width: 200, height: 45),
        ),
      );
}
