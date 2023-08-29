import 'dart:io';

class Customer {
   String name;
   String email;
   String contact;
   String loyalityPoints;
   File? image;

   Customer({
    required this.name,
    required this.email,
    required this.contact,
    required this.loyalityPoints,
    this.image,
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
