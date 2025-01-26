import 'package:flutter/material.dart';
import '../functions/fetch_country_details.dart';
import '../models/country_model.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(country.flag, height: 200),
              const SizedBox(height: 16),
              Text(
                'Главен град: ${country.capital}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Регион: ${country.region}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),

              FutureBuilder<String>(
                future: fetchCountryDetails(country.name),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Text(
                      snapshot.data ?? 'No details available.',
                      style: const TextStyle(fontSize: 18, height: 1.5),
                    );
                  } else {
                    return const Text('No details available.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
