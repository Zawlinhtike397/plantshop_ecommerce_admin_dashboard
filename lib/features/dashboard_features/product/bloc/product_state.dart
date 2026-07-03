part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<PlantModel> allProducts;
  final List<PlantModel> filteredProducts;

  const ProductLoaded({
    required this.allProducts,
    required this.filteredProducts,
  });

  @override
  List<Object> get props => [allProducts, filteredProducts];
}

class ProductActionSuccess extends ProductState {
  final String message;
  const ProductActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
