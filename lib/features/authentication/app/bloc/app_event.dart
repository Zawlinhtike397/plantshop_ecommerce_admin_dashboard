part of 'app_bloc.dart';

sealed class AppEvent {}

final class AppStarted extends AppEvent {}

final class LoggedIn extends AppEvent {}

final class LoggedOut extends AppEvent {}
