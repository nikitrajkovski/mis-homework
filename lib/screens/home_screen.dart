import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/country_model.dart';
import '../widgets/country_card.dart';
import 'country_detail_screen.dart';
import 'random_country_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Country>> _countries;
  final Set<String> _favorites = {};

  @override
  void initState() {
    super.initState();
    _countries = ApiService().fetchCountries();
  }

  void _toggleFavorite(String countryName) {
    setState(() {
      if (_favorites.contains(countryName)) {
        _favorites.remove(countryName);
      } else {
        _favorites.add(countryName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Држави'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RandomCountryScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    favorites: _favorites.toList(),
                    onFavoriteToggle: _toggleFavorite,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Country>>(
        future: _countries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final countries = snapshot.data!..sort((a, b) => a.name.compareTo(b.name)); // Sort alphabetically
            return ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                final isFavorite = _favorites.contains(country.name);
                return CountryCard(
                  country: country,
                  isFavorite: isFavorite,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountryDetailScreen(country: country),
                      ),
                    );
                  },
                  onFavoriteToggle: () => _toggleFavorite(country.name),
                );
              },
            );
          } else {
            return const Center(child: Text('No countries available'));
          }
        },
      ),
    );
  }
}