class Bids {
  final String bidId;
  final String serviceId;
  final String serviceProId;
  final String timeStamp;
  final String additionalInfo;
  final String amount;
  final String contact;
  final String name;
  // final String acceptCustomerId;
  // final String acceptTimestamp;

  const Bids({
    required this.bidId,
    required this.serviceId,
    required this.serviceProId,
    required this.timeStamp,
    required this.additionalInfo,
    required this.amount,
    required this.contact,
    required this.name,
    // required this.acceptCustomerId,
    // required this.acceptTimestamp
  });

  factory Bids.fromJson(Map<String, dynamic> json) {
    return Bids(
      bidId: json['id'],
      serviceId: json['serviceId'],
      serviceProId: json['serviceProviderId'],
      contact: json['contact'],
      amount: json['amount'].toString(),
      name: json['name'],
      timeStamp: json['timestamp'],
      additionalInfo: json['additionalInfo'],
      // acceptCustomerId: json['accept_customerid'],
      // acceptTimestamp: json['accept_timestamp'],
    );
  }
  
}
