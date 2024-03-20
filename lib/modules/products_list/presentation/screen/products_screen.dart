import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

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
            Loading() => const CircularProgressIndicator().align(),
            Error() => Text(state.message),
            Empty() => const SizedBox.shrink(),
            //? Pattern matching
            Success(products: final List<Product> products) => Column(
                children: [
                  ...products.map((p) => _ProductCard(p).symmetricPadding(vertical: 20)).toList(),
                  ElevatedButton(
                    child: const Text("Clear"),
                    onPressed: () => context.read<ProductsBloc>().add(ClearProducts()),
                  ).resize(width: 100, height: 45),
                ],
              ).customPadding(top: 30),
          },
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: ElevatedButton(
            child: const Text("Get products"),
            onPressed: () => context.read<ProductsBloc>().add(GetProducts(Random().nextInt(20))),
          ).resize(width: 200, height: 45),
        ),
      ),
    );
  }
}
