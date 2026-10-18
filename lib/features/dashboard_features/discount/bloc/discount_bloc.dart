import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantfiy_plantshop_admin_dashboard/data/repositories/discount_repository.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/model/discount_model.dart';

part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  final DiscountRepository discountRepository;

  DiscountBloc(this.discountRepository) : super(DiscountInitial()) {
    on<FetchDiscounts>(_fetchDiscounts);
    on<SearchDiscounts>(_searchDiscounts);
    on<CreateDiscount>(_createDiscount);
    on<UpdateDiscount>(_updateDiscount);
    on<DeleteDiscount>(_deleteDiscount);
  }

  Future<void> _fetchDiscounts(
    FetchDiscounts event,
    Emitter<DiscountState> emit,
  ) async {
    emit(DiscountLoading());

    try {
      final discounts = await discountRepository.getDiscounts();

      emit(DiscountLoaded(discounts: discounts, filteredDiscounts: discounts));
    } catch (e) {
      emit(DiscountError('Failed to load discounts. Please try again.'));
    }
  }

  void _searchDiscounts(SearchDiscounts event, Emitter<DiscountState> emit) {
    if (state is! DiscountLoaded) return;

    final currentState = state as DiscountLoaded;
    final query = event.query.trim().toLowerCase();

    final filtered = currentState.discounts.where((discount) {
      return discount.code.toLowerCase().contains(query) ||
          discount.title.toLowerCase().contains(query);
    }).toList();

    emit(
      DiscountLoaded(
        discounts: currentState.discounts,
        filteredDiscounts: filtered,
      ),
    );
  }

  Future<void> _createDiscount(
    CreateDiscount event,
    Emitter<DiscountState> emit,
  ) async {
    try {
      await discountRepository.createDiscount(event.discount);
      add(const FetchDiscounts());
    } catch (e) {
      emit(DiscountError('Failed to create discount: ${e.toString()}'));
    }
  }

  Future<void> _updateDiscount(
    UpdateDiscount event,
    Emitter<DiscountState> emit,
  ) async {
    try {
      await discountRepository.updateDiscount(event.discount);
      add(const FetchDiscounts());
    } catch (e) {
      emit(DiscountError('Failed to update discount: ${e.toString()}'));
    }
  }

  Future<void> _deleteDiscount(
    DeleteDiscount event,
    Emitter<DiscountState> emit,
  ) async {
    try {
      await discountRepository.deleteDiscount(event.id);
      add(const FetchDiscounts());
    } catch (e) {
      emit(DiscountError('Failed to delete discount: ${e.toString()}'));
    }
  }
}
