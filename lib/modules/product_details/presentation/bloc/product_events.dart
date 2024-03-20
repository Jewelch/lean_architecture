import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetProduct extends ProductEvent {
  final int id;

  GetProduct(this.id);

  @override
  List<Object> get props => [];
}

final class ClearProduct extends ProductEvent {}

final class Hachwa extends ProductEvent {}
