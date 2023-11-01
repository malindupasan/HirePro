class ServiceProvider {
  final String id;
  final String contact;
  final String name;
  final String email;
  final String points;
  final String bankDetails;
  final String intro;
  final List<String> category;
  final List<Review> reviews;

  ServiceProvider(
      {required this.id,
      required this.contact,
      required this.name,
      required this.email,
      required this.points,
      required this.bankDetails,
      required this.category,
      required this.reviews,
      required this.intro});

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    List<dynamic> reviewList = json['reviews'] ?? [];
    List<Review> reviews =
        reviewList.map((reviewJson) => Review.fromJson(reviewJson)).toList();

    return ServiceProvider(
      id: json['id'] ?? '',
      contact: json['contact'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      points: json['points'] ?? '',
      bankDetails: json['bank_details'] ?? '',
      category: List<String>.from(json['category'] ?? []),
      reviews: reviews,
      intro: json['intro'] ?? '',
    );
  }
}

class Review {
  final String id;
  final String comment;
  final String starRate;
  final String customerId;
  final String serviceProviderId;
  final DateTime date;
  final String name;

  Review({
    required this.id,
    required this.comment,
    required this.starRate,
    required this.customerId,
    required this.serviceProviderId,
    required this.date,
    required this.name,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      comment: json['comment'] ?? '',
      starRate: json['starRate'].toString() ?? '0',
      customerId: json['customerid'] ?? '',
      serviceProviderId: json['serviceproviderid'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      name: json['name'] ?? '',
    );
  }
}
