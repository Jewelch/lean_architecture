import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetProduct extends ProductEvent {}

final class ClearProduct extends ProductEvent {}
