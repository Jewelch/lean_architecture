import 'package:equatable/equatable.dart';

import '../../../common/domain/entities/product.dart';

sealed class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

final class Idle extends ProductState {}

final class Loading extends ProductState {}

final class Empty extends ProductState {}

final class Success extends ProductState {
  final Product product;

  Success({required this.product});

  @override
  List<Object> get props => [product];
}

final class Error extends ProductState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
