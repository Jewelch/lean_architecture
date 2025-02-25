import '../../../../../base/screens/exports.dart';
import '../binding/product_screen_deps.dart';
import 'bloc/product_bloc.dart';
import 'bloc/product_events.dart';
import 'bloc/product_states.dart';
import 'widgets/clear_button.dart';

final class ProductDetailsScreen extends BlocProviderWidget<ProductDetailsBloc> {
  ProductDetailsScreen({super.key})
      : super(
          dependencies: ProductScreenDependencies(),
          listenWhen: (previous, current) => true,
          fullRebuildWhen: (_, currentState) => false,
        );

  @override
  Widget build(BuildContext context) => SmartScaffold(
        bottomBarParent: BottomBarParents.product,
        title: 'Product Details',
        body: BlocBuilder<ProductDetailsBloc, ProductState>(
          builder: (context, state) => switch (state) {
            Idle() => TextFormField(controller: bloc.textEditingController).center().overallPadding(30),
            Loading() => const CircularProgressIndicator(strokeWidth: 1).squared(20).center(),
            Error() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                  ClearButton<ProductDetailsBloc>(),
                ],
              ),
            Empty() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  const Text("No data").center(),
                  ClearButton<ProductDetailsBloc>(),
                ],
              ),

            //? Pattern matching
            Success(product: final product) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  ProductCard(product),

                  //! RECOMMENDED APPROACH
                  ClearButton<ProductDetailsBloc>(),

                  //? ALTERNATIVE APPROACH
                  ClearButton2(bloc),
                ],
              ),
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
          child: const Text("Get product"),
          onPressed: () => bloc.add(GetProduct()),
        ).resize(width: 200, height: 45),
      );
}
