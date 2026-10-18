import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantfiy_plantshop_admin_dashboard/data/repositories/order_repository.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;

  OrderBloc({required this.repository}) : super(OrderInitial()) {
    on<FetchOrders>(_fetchOrders);
    on<SearchOrders>(_searchOrders);
    on<UpdateOrderStatusEvent>(_updateOrderStatus);
  }

  Future<void> _fetchOrders(FetchOrders event, Emitter<OrderState> emit) async {
    try {
      emit(OrderLoading());

      final orders = await repository.getOrders();

      emit(OrderLoaded(orders: orders, filteredOrders: orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  void _searchOrders(SearchOrders event, Emitter<OrderState> emit) {
    if (state is OrderLoaded) {
      final currentState = state as OrderLoaded;
      final query = event.query.toLowerCase();

      final filtered = currentState.orders.where((order) {
        final orderId = (order.id ?? '').toLowerCase();
        final customerName = (order.customerName ?? 'Mr.Bean').toLowerCase();
        final items = order.items;
        bool nameMatched = false;

        if (items != null) {
          nameMatched = items.any((item) {
            final plantName = (item.plant?.name ?? '').toLowerCase();
            return plantName.contains(query);
          });
        }

        return orderId.contains(query) ||
            customerName.contains(query) ||
            nameMatched;
      }).toList();

      emit(OrderLoaded(orders: currentState.orders, filteredOrders: filtered));
    }
  }

  Future<void> _updateOrderStatus(
    UpdateOrderStatusEvent event,
    Emitter<OrderState> emit,
  ) async {
    if (state is OrderLoaded) {
      final currentState = state as OrderLoaded;
      try {
        await repository.updateOrderStatus(event.orderId, event.status);

        final updatedOrders = currentState.orders.map((order) {
          if (order.id == event.orderId) {
            return order.copyWith(status: event.status);
          }
          return order;
        }).toList();

        emit(OrderLoaded(orders: updatedOrders, filteredOrders: updatedOrders));
      } catch (e) {
        emit(OrderError(e.toString()));
      }
    }
  }
}
