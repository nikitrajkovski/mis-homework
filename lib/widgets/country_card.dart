import 'package:flutter/material.dart';
import '../models/country_model.dart';

class CountryCard extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;

  const CountryCard({
    super.key,
    required this.country,
    required this.onTap,
    required this.onFavoriteToggle,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Image.network(country.flag, width: 50, height: 50),
        title: Text(country.name),
        subtitle: Text(country.capital),
        trailing: IconButton(
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
          onPressed: onFavoriteToggle,
        ),
        onTap: onTap,
      ),
    );
  }
}
