import 'dart:math';

import '../../../../base/screens/exports.dart';
import '../../common/domain_entities/product.dart';
import '../binding/products_screen_deps.dart';
import 'bloc/products_bloc.dart';
import 'bloc/products_events.dart';
import 'bloc/products_states.dart';

final class ProductsScreen extends BlocProviderWidget<ProductsBloc> {
  ProductsScreen({super.key})
      : super(
          dependencies: ProductsDependencies(),
        );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductState>(
      builder: (context, state) => SmartScaffold(
        bottomBarParent: BottomBarParents.list,
        title: "Products List",
        body: switch (state) {
          Idle() => const SizedBox.shrink(),
          Loading() => const CircularProgressIndicator(strokeWidth: 1).squared(20).center(),
          Error(message: final String message) => Text(message),
          Empty() => const SizedBox.shrink(),
          //? Pattern matching
          Success(products: final List<Product> products) => Column(
              children: [
                ElevatedButton(
                  child: const Text("Clear"),
                  onPressed: () => context.read<ProductsBloc>().add(ClearProducts()),
                ).resize(width: 100, height: 45).symmetricPadding(vertical: 15),
                ListView.builder(
                  itemCount: products.length,
                  padding: const EdgeInsets.only(bottom: 100),
                  itemBuilder: (context, index) => ProductCard(products[index]),
                ).expanded(),
              ],
            ),
        },
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
          child: const Text("Get products"),
          onPressed: () => context.read<ProductsBloc>().add(GetProducts(Random().nextInt(20))),
        ).resize(width: 200, height: 45),
      ),
    );
  }
}
