import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetProduct extends ProductEvent {
  final String id;

  GetProduct([this.id = "0"]);

  @override
  List<Object> get props => [];
}

final class ClearProduct extends ProductEvent {}
