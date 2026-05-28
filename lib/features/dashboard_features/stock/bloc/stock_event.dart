part of 'stock_bloc.dart';

sealed class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object> get props => [];
}

class FetchLowStockItems extends StockEvent {}

class ReorderPlant extends StockEvent {
  final int plantId;
  final int currentStock;
  final int maxStock;

  const ReorderPlant({
    required this.plantId,
    required this.currentStock,
    required this.maxStock,
  });

  @override
  List<Object> get props => [plantId, currentStock, maxStock];
}
