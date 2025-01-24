class Country {
  final String name;
  final String capital;
  final String region;
  final String flag;

  Country({required this.name, required this.capital, required this.region, required this.flag});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      capital: (json['capital'] as List<dynamic>?)?.first ?? 'N/A',
      region: json['region'],
      flag: json['flags']['png'],
    );
  }
}