part of 'stock_bloc.dart';

sealed class StockState extends Equatable {
  const StockState();

  @override
  List<Object> get props => [];
}

final class StockInitial extends StockState {}

final class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final List<LowStockItem> items;

  const StockLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class StockError extends StockState {
  final String message;

  const StockError(this.message);

  @override
  List<Object> get props => [message];
}
