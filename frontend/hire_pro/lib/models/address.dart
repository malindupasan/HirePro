class Address {
  final String id;
  final String address;
  final String title;
  final String latitude;
  final String longitude;

  const Address({
    required this.id,
    required this.address,
    required this.title,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
       id: json['id'],
      address: json['address'],
      title: json['title'],
      latitude: json['latitude'] != null ? json['latitude'] : null,
      longitude: json['longitude'] != null ? json['longitude'] : null,
    );
  }
}

