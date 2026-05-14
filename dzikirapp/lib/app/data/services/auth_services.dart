import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final supabase = Supabase.instance.client.auth;

  Future<bool> signUp(String password, String email) async {
    try {
      final response = await supabase.signUp(password: password, email: email);

      return true;
    } catch (e) {
      print('AUTH SERVICE ERROR: $e');
      return false;
    }
  }

  Future<bool> login(String password, String email) async {
    try {
      final response = await supabase.signInWithPassword(
        password: password,
        email: email,
      );
      return true;
    } catch (e) {
      print('AUTH SERVICE ERROR: $e');
      return false;
    }
  }
}
