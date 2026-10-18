part of 'discount_bloc.dart';

sealed class DiscountState extends Equatable {
  const DiscountState();

  @override
  List<Object> get props => [];
}

final class DiscountInitial extends DiscountState {}

final class DiscountLoading extends DiscountState {}

final class DiscountLoaded extends DiscountState {
  final List<DiscountModel> discounts;
  final List<DiscountModel> filteredDiscounts;

  const DiscountLoaded({
    required this.discounts,
    required this.filteredDiscounts,
  });

  @override
  List<Object> get props => [discounts, filteredDiscounts];
}

final class DiscountError extends DiscountState {
  final String message;

  const DiscountError(this.message);

  @override
  List<Object> get props => [message];
}
