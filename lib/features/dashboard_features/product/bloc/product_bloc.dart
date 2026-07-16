import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantfiy_plantshop_admin_dashboard/data/repositories/product_repository.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<FetchAllProducts>(_fetchAllProducts);
    on<SearchProducts>(_searchProducts);
    on<AddNewProduct>(_addNewProduct);
    on<UpdateExistingProduct>(_updateProduct);
    on<DeleteProduct>(_deleteProduct);
  }

  Future<void> _fetchAllProducts(
    FetchAllProducts event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());
      final products = await repository.getAllProducts();
      emit(ProductLoaded(allProducts: products, filteredProducts: products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _searchProducts(SearchProducts event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final query = event.query.toLowerCase();

      final filtered = currentState.allProducts.where((plant) {
        final plantName = plant.name.toLowerCase();
        final plantCategory = plant.category.toLowerCase();

        return plantName.contains(query) || plantCategory.contains(query);
      }).toList();

      emit(
        ProductLoaded(
          allProducts: currentState.allProducts,
          filteredProducts: filtered,
        ),
      );
    }
  }

  Future<void> _addNewProduct(
    AddNewProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());
      await repository.addProduct(event.plant);
      emit(ProductActionSuccess("Product added successfully!"));
      add(FetchAllProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
      add(FetchAllProducts());
    }
  }

  Future<void> _updateProduct(
    UpdateExistingProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());
      await repository.updateProduct(event.plant);
      emit(const ProductActionSuccess("Product updated successfully!"));
      add(FetchAllProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
      add(FetchAllProducts());
    }
  }

  Future<void> _deleteProduct(
    DeleteProduct event,
    Emitter<ProductState> emit,
  ) async {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      try {
        emit(ProductLoading());

        await repository.deleteProduct(event.plantId);

        final updatedAllProducts = currentState.allProducts
            .where((plant) => plant.id != event.plantId)
            .toList();

        final updatedFilteredProducts = currentState.filteredProducts
            .where((plant) => plant.id != event.plantId)
            .toList();

        emit(
          ProductLoaded(
            allProducts: updatedAllProducts,
            filteredProducts: updatedFilteredProducts,
          ),
        );
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    }
  }
}
