import '../../../../../base/bloc/base_states.dart';
import '../../../../../base/screens/exports.dart';
import '../../../common/presentation/widgets/clear_button.dart';
import '../../dependencies/product_screen_deps.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_events.dart';
import '../bloc/product_states.dart';

final class ProductDetailsScreenEnum extends BlocProviderWidget<ProductDetailsBlocEnum> {
  ProductDetailsScreenEnum({super.key})
      : super(
          dependencies: ProductScreenDependencies(),
        );

  @override
  Widget build(BuildContext context) => SmartScaffold(
        bottomBarParent: BottomBarParents.product,
        title: 'Product details (Enum)',
        body: BlocBuilder<ProductDetailsBlocEnum, ProductStates>(
          builder: (context, state) => switch (state.state) {
            BaseStateEnum.idle =>
              TextFormField(controller: bloc.textEditingController).center().overallPadding(30),
            BaseStateEnum.loading =>
              const CircularProgressIndicator(strokeWidth: 1).squared(20).center(),
            BaseStateEnum.error => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message!).center(),
                  ClearButton<ProductDetailsBlocEnum>().customPadding(top: 16),
                ],
              ),
            BaseStateEnum.empty => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No data").center(),
                  ClearButton<ProductDetailsBlocEnum>().customPadding(top: 16),
                ],
              ),
            BaseStateEnum.success => Column(
                children: [
                  ProductCard(state.data!).customPadding(bottom: 20, top: 50),
                  ClearButton<ProductDetailsBlocEnum>(),
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
