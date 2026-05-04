import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/data/repositories/authentication_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository authRepository;
  AppBloc({required this.authRepository}) : super(AppInitial()) {
    on<AppStarted>(_onStarted);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onStarted(AppStarted event, Emitter<AppState> emit) async {
    final user = authRepository.getCurrentUser();

    if (user == null) {
      emit(AppUnauthenticated());
      return;
    }

    final isAdmin = await authRepository.isAdmin();

    if (isAdmin) {
      emit(AppAuthenticated());
    } else {
      emit(AppUnauthorized());
    }
  }

  void _onLoggedOut(LoggedOut event, Emitter<AppState> emit) async {
    await authRepository.signOut();
    emit(AppUnauthenticated());
  }
}
