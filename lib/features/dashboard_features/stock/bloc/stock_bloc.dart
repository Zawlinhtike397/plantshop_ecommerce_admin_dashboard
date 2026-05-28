import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantfiy_plantshop_admin_dashboard/data/repositories/stock_repository.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/stock/model/low_stock_item_model.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockRepository repository;
  StockBloc({required this.repository}) : super(StockInitial()) {
    on<FetchLowStockItems>(_fetchLowStockItems);
    on<ReorderPlant>(_reorderPlant);
  }

  Future<void> _fetchLowStockItems(
    FetchLowStockItems event,
    Emitter<StockState> emit,
  ) async {
    try {
      emit(StockLoading());

      final items = await repository.getLowStockItems();

      emit(StockLoaded(items));
    } catch (e) {
      emit(StockError(e.toString()));
    }
  }

  Future<void> _reorderPlant(
    ReorderPlant event,
    Emitter<StockState> emit,
  ) async {
    try {
      await repository.reorderPlant(
        plantId: event.plantId,
        currentStock: event.currentStock,
        maxStock: event.maxStock,
      );

      final items = await repository.getLowStockItems();

      emit(StockLoaded(items));
    } catch (e) {
      emit(StockError(e.toString()));
    }
  }
}
