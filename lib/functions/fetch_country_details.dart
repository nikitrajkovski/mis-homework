import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> fetchCountryDetails(String countryName) async {
  final String url =
      'https://en.wikipedia.org/w/api.php?action=query&prop=extracts&exintro&explaintext&format=json&titles=$countryName';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final pageId = data['query']['pages'].keys.first;
    final extract = data['query']['pages'][pageId]['extract'];
    return extract ?? 'No details available for this country.';
  } else {
    throw Exception('Failed to load country details');
  }
}