import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../base/screens/exports.dart';
import '../../../../main.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_events.dart';
import '../bloc/product_states.dart';
import '../bloc/products_bloc.dart';

part '../widgets/product_card.dart';

final class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => sl<ProductBloc>(),
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Product details'),
          ),
          body: switch (state) {
            Idle() => const SizedBox.shrink(),
            Loading() => const CircularProgressIndicator().align(),
            Error() => Text(state.message),
            Empty() => const SizedBox.shrink(),
            //? Pattern matching
            Success(product: final product) => Column(
                children: [
                  _ProductCard(product).customPadding(bottom: 20, top: 50),
                  ElevatedButton(
                    child: const Text("Clear"),
                    onPressed: () => context.read<ProductBloc>().add(ClearProduct()),
                  ).resize(width: 100, height: 45),
                ],
              ),
          },
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: ElevatedButton(
            child: const Text("Get product"),
            onPressed: () => context.read<ProductBloc>().add(GetProduct(Random().nextInt(20))),
          ).resize(width: 200, height: 45),
        ),
      ),
    );
  }
}
