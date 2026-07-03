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

class AddNewProduct extends ProductEvent {
  final PlantModel plant;
  const AddNewProduct(this.plant);

  @override
  List<Object> get props => [plant];
}

class DeleteProduct extends ProductEvent {
  final String plantId;

  const DeleteProduct(this.plantId);

  @override
  List<Object> get props => [plantId];
}
