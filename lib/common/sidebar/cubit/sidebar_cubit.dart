import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantfiy_plantshop_admin_dashboard/routes/app_routes.dart';

part 'sidebar_state.dart';

class SidebarCubit extends Cubit<SidebarState> {
  SidebarCubit() : super(const SidebarInitial());

  void setActive(String route) {
    emit(SidebarUpdated(activeItem: route, hoverItem: ''));
  }

  void setHover(String route) {
    if (route != state.activeItem) {
      emit(SidebarUpdated(activeItem: state.activeItem, hoverItem: route));
    }
  }

  void clearHover() {
    emit(SidebarUpdated(activeItem: state.activeItem, hoverItem: ''));
  }

  bool isActive(String route) => state.activeItem == route;

  bool isHovering(String route) => state.hoverItem == route;
}
