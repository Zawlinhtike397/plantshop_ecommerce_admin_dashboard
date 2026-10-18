part of 'discount_bloc.dart';

sealed class DiscountEvent extends Equatable {
  const DiscountEvent();

  @override
  List<Object> get props => [];
}

final class FetchDiscounts extends DiscountEvent {
  const FetchDiscounts();
}

final class SearchDiscounts extends DiscountEvent {
  final String query;

  const SearchDiscounts(this.query);

  @override
  List<Object> get props => [query];
}

final class CreateDiscount extends DiscountEvent {
  final DiscountModel discount;

  const CreateDiscount(this.discount);

  @override
  List<Object> get props => [discount];
}

final class UpdateDiscount extends DiscountEvent {
  final DiscountModel discount;

  const UpdateDiscount(this.discount);

  @override
  List<Object> get props => [discount];
}

final class DeleteDiscount extends DiscountEvent {
  final String id;

  const DeleteDiscount(this.id);

  @override
  List<Object> get props => [id];
}
