import 'package:flutter/material.dart';
import '../models/country_model.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(country.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(country.flag, height: 200),
            const SizedBox(height: 16),
            Text('Capital: ${country.capital}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Region: ${country.region}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}