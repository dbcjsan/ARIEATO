import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: const String.fromEnvironment('SUPABASE_URL', defaultValue: 'https://your-project.supabase.co'),
      anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: 'your-anon-key'),
    );
  }

  // Auth methods
  static Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth.signInWithPassword(email: email, password: password);
  }

  static Future<AuthResponse> signUp(String email, String password) async {
    return await client.auth.signUp(email: email, password: password);
  }

  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  static User? get currentUser => client.auth.currentUser;

  static Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;

  // User profile methods
  static Future<Map<String, dynamic>?> getUserProfile() async {
    final user = currentUser;
    if (user == null) return null;

    final response = await client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();
    
    return response;
  }

  // Dashboard data methods
  static Future<List<Map<String, dynamic>>> getDashboardStats() async {
    final response = await client.from('dashboard_stats').select();
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await client.from('users').select();
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<List<Map<String, dynamic>>> getChartData() async {
    final response = await client.from('chart_data').select();
    return List<Map<String, dynamic>>.from(response);
  }
}