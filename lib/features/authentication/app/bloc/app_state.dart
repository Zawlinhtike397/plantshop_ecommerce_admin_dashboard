part of 'app_bloc.dart';

sealed class AppState {}

final class AppInitial extends AppState {}

final class AppAuthenticated extends AppState {}

final class AppUnauthenticated extends AppState {}

final class AppUnauthorized extends AppState {}
