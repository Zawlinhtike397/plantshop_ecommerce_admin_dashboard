part of 'sidebar_cubit.dart';

sealed class SidebarState extends Equatable {
  final String activeItem;
  final String hoverItem;

  const SidebarState({required this.activeItem, required this.hoverItem});

  @override
  List<Object> get props => [activeItem, hoverItem];
}

final class SidebarInitial extends SidebarState {
  const SidebarInitial()
    : super(activeItem: AppRoutes.dashboard, hoverItem: '');
}

final class SidebarUpdated extends SidebarState {
  const SidebarUpdated({required super.activeItem, required super.hoverItem});
}
