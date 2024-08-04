import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lean_architecture/api/data_source.dart';
import 'package:lean_requester/observable.dart';

import '../../../../base/screens/exports.dart';
import '../../domain/entities/product.dart';
import '../../injections.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_events.dart';
import '../bloc/product_states.dart';

part '../widgets/product_card.dart';

final class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key}) {
    ProductScreenDependencies.inject();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailsBlocImpl>(
      create: (_) => GetIt.instance<ProductDetailsBlocImpl>(),
      child: BlocConsumer<ProductDetailsBlocImpl, ProductState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Product details'),
          ),
          body: switch (state) {
            Idle() => const Text("Idle").center(),
            Loading() => const CircularProgressIndicator(strokeWidth: 1).squared(side: 20).center(),
            Error() => Text(state.message),
            Empty() => const SizedBox.shrink(),
            //? Pattern matching
            Success(product: final product) => Column(
                children: [
                  _ProductCard(product).customPadding(bottom: 20, top: 50),
                  ElevatedButton(
                    child: const Text("Clear"),
                    onPressed: () => context.read<ProductDetailsBlocImpl>().add(ClearProduct()),
                  ).resize(width: 100, height: 45),
                ],
              ),
          },
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: ElevatedButton(
            child: const Text("Get product"),
            onPressed: () => context.read<ProductDetailsBlocImpl>().add(GetProduct(Random().nextInt(20))),
          ).resize(width: 200, height: 45),
          bottomNavigationBar: Observer(
              observes: connectivityManager.isConnectedObs,
              builder: (context, isConnected) => Container(
                    height: 25,
                    width: double.infinity,
                    color: isConnected ? Colors.green : Colors.red,
                  )),
        ),
      ),
    );
  }
}
