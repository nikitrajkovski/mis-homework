import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/country_model.dart';

class RandomCountryScreen extends StatefulWidget {
  const RandomCountryScreen({super.key});

  @override
  State<RandomCountryScreen> createState() => _RandomCountryScreenState();
}

class _RandomCountryScreenState extends State<RandomCountryScreen> {
  late Future<Country> _randomCountry;

  @override
  void initState() {
    super.initState();
    _randomCountry = _fetchRandomCountry();
  }

  Future<Country> _fetchRandomCountry() async {
    final countries = await ApiService().fetchCountries();
    countries.shuffle();
    return countries.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Рандом изберена држава'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Country>(
        future: _randomCountry,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final country = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(country.flag, height: 200),
                  const SizedBox(height: 16),
                  Text('Name: ${country.name}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Capital: ${country.capital}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Region: ${country.region}',
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No country available'));
          }
        },
      ),
    );
  }
}
