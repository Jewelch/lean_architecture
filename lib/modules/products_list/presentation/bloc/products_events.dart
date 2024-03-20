import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetProducts extends ProductEvent {
  final int id;

  GetProducts(this.id);

  @override
  List<Object> get props => [];
}

final class ClearProducts extends ProductEvent {}
