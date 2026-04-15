/// Represents a company entity returned from the API.
class Company {
  final int id;
  final String name;
  final String address;
  final String country;
  final int employeeCount;
  final String industry;
  final String ceoName;

  /// Whether this company is marked as a favorite by the user.
  bool isFavorite;

  Company({
    required this.id,
    required this.name,
    required this.address,
    required this.country,
    required this.employeeCount,
    required this.industry,
    required this.ceoName,
    this.isFavorite = false,
  });

  /// Creates a [Company] from a JSON map returned by the API.
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'No Name',
      address: json['address'] ?? 'No Address',
      country: json['country'] ?? 'Unknown',
      employeeCount: json['employeeCount'] ?? 0,
      industry: json['industry'] ?? 'Unknown',
      ceoName: json['ceoName'] ?? 'Unknown',
    );
  }

  /// Converts this [Company] to a JSON map for local storage.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'country': country,
        'employeeCount': employeeCount,
        'industry': industry,
        'ceoName': ceoName,
        'isFavorite': isFavorite,
      };
}
