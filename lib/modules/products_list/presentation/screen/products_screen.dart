import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lean_requester/managers_exp.dart';
import 'package:lean_requester/observable.dart';

import '../../../../base/screens/exports.dart';
import '../../../../main.dart';
import '../../../product_details/domain/entities/product.dart';
import '../../injections.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_events.dart';
import '../bloc/products_states.dart';

part '../widgets/product_card.dart';

final class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key}) {
    ProductsDependencies.inject();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsBloc>(
      create: (_) => sl<ProductsBloc>(),
      child: BlocConsumer<ProductsBloc, ProductState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Products List'),
          ),
          body: switch (state) {
            Idle() => const SizedBox.shrink(),
            Loading() => const CircularProgressIndicator(strokeWidth: 1).squared(side: 20).center(),
            Error() => Text(state.message),
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
                    itemBuilder: (context, index) => _ProductCard(products[index]),
                  ).expanded(),
                ],
              ),
          },
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: ElevatedButton(
            child: const Text("Get products"),
            onPressed: () => context.read<ProductsBloc>().add(GetProducts(Random().nextInt(20))),
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
