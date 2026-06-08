part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchAllProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object> get props => [query];
}

class DeleteProduct extends ProductEvent {
  final int plantId;

  const DeleteProduct(this.plantId);

  @override
  List<Object> get props => [plantId];
}
