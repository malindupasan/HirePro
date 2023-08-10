class Customer {
  final String name;
  final String email;
  final String contact;
  final String loyalityPoints;

  const Customer({
    required this.name,
    required this.email,
    required this.contact,
    required this.loyalityPoints,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      email: json['email'],
      contact: json['contact'],
      loyalityPoints: json['loyalty_points'],
    );
  }
}
