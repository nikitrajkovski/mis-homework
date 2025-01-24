import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country_model.dart';

class ApiService {
  static const String _baseUrl = 'https://restcountries.com/v3.1/all';

  Future<List<Country>> fetchCountries() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Country.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}