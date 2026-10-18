part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

final class FetchOrders extends OrderEvent {}

class SearchOrders extends OrderEvent {
  final String query;

  const SearchOrders(this.query);

  @override
  List<Object> get props => [query];
}

class UpdateOrderStatusEvent extends OrderEvent {
  final String orderId;
  final String status;

  const UpdateOrderStatusEvent({required this.orderId, required this.status});

  @override
  List<Object> get props => [orderId, status];
}
