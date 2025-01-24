import 'package:flutter/material.dart';
import '../widgets/country_card.dart';
import '../models/country_model.dart';
import '../services/api_service.dart';
import 'country_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final List<String> favorites;
  final Function(String) onFavoriteToggle;

  const FavoritesScreen({
    super.key,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<String> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = widget.favorites;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваши омиелни држави'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Country>>(
        future: ApiService().fetchCountries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final countries = snapshot.data!
                .where((country) => _favorites.contains(country.name))
                .toList()
              ..sort((a, b) => a.name.compareTo(b.name));

            if (countries.isEmpty) {
              return const Center(child: Text('No favorites selected'));
            }

            return ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return CountryCard(
                  country: country,
                  isFavorite: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CountryDetailScreen(country: country),
                      ),
                    );
                  },
                  onFavoriteToggle: () {
                    widget.onFavoriteToggle(country.name);
                    setState(() {
                      _favorites.remove(country.name);
                    });
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No favorites available'));
          }
        },
      ),
    );
  }
}
