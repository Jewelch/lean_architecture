import 'package:equatable/equatable.dart';

import '../../../common/domain_entities/product.dart';

sealed class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

final class Idle extends ProductState {}

final class Loading extends ProductState {}

final class Empty extends ProductState {}

final class Success extends ProductState {
  final List<Product> products;

  Success({required this.products});

  @override
  List<Object> get props => [products];
}

final class Error extends ProductState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
