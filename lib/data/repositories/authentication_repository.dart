import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationRepository {
  final _supabase = Supabase.instance.client;

  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  Future<bool> isAdmin() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return false;

    final response = await _supabase
        .from('Users')
        .select('role')
        .eq('user_id', user.id)
        .single();

    return response['role'] == 'admin';
  }

  Future<void> signIn({required String email, required String password}) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
