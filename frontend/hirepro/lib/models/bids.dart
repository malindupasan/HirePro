class Bids {
  final String? id;
  final String address;
  final String title;
  final String latitude;
  final String longitude;

  const Bids({
     this.id,
    required this.address,
    required this.title,
    required this.latitude,
    required this.longitude,
  });

  factory Bids.fromJson(Map<String, dynamic> json) {
    return Bids(
       id: json['id'],
      address: json['address'],
      title: json['title'],
      latitude: json['latitude'] != null ? json['latitude'] : null,
      longitude: json['longitude'] != null ? json['longitude'] : null,
    );
  }
}

