import '../../../../base/bloc/base_states.dart';
import '../../../../base/screens/exports.dart';
import '../../dependencies/product_screen_deps.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_events.dart';
import '../bloc/product_states.dart';

final class ProductDetailsScreenEnum extends FullBlocProvidingWidget<ProductDetailsBlocEnum> {
  ProductDetailsScreenEnum({super.key}) : super(dependencies: ProductScreenDependencies());

  @override
  Widget build(BuildContext context) => SmartScaffold(
        bottomBarParent: BottomBarParents.product,
        title: 'Product details',
        body: BlocBuilder<ProductDetailsBlocEnum, ProductStates>(
          builder: (context, state) => switch (state.state) {
            BaseStateEnum.idle =>
              TextFormField(controller: bloc.textEditingController).center().overallPadding(30),
            BaseStateEnum.loading =>
              const CircularProgressIndicator(strokeWidth: 1).squared(20).center(),
            BaseStateEnum.error => Text(state.message!),
            BaseStateEnum.empty => const SizedBox.shrink(),
            BaseStateEnum.success => Column(
                children: [
                  ProductCard(state.data!).customPadding(bottom: 20, top: 50),
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
