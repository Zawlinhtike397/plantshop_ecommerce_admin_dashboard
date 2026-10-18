part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  final List<OrderModel> filteredOrders;

  const OrderLoaded({required this.orders, required this.filteredOrders});

  @override
  List<Object> get props => [orders, filteredOrders];
}

class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);
}
