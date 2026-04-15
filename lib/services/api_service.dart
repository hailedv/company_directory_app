import 'dart:convert';
import 'package:http/http.dart' as http;

/// Handles all HTTP communication with the remote API.
class ApiService {
  static const String baseUrl = 'https://fake-json-api.mock.beeceptor.com';
  static const String companiesEndpoint = '/companies';

  /// Fetches the list of companies from the API.
  /// Throws an [Exception] if the request fails.
  Future<List<Map<String, dynamic>>> fetchCompanies() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$companiesEndpoint'),
        headers: {'Accept': 'application/json'},
      );

      await Future.delayed(const Duration(seconds: 1));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load companies: $e');
    }
  }

  /// Submits user feedback to the API.
  /// Returns true on success, false on failure.
  Future<bool> submitFeedback({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return true;
    } catch (e) {
      return false;
    }
  }
}
