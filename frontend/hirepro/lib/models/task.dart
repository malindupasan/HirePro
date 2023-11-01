class Task {
  String? id;
  String? area;
  String description;
  String? postedtime;
  String estmin;
  String estmax;
  String location;
  String? date;
  String latitude;
  String longitude;
  String? percentage;
  String? status;
  String? amount;
  String? category;
  String? serviceProvider;
  String? spid;
  Task(
      {this.id,
      this.area,
      required this.description,
      this.postedtime,
      required this.estmax,
      required this.estmin,
      required this.location,
      this.date,
      required this.latitude,
      required this.longitude,
      this.percentage,
      this.status,
      this.amount,
      this.category,
      this.serviceProvider,this.spid});
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        area: json['area'],
        description: json['description'],
        postedtime: json['postedtime'],
        estmin: json['estmin'].toString(),
        estmax: json['estmax'].toString(),
        location: json['location'],
        date: json['date'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        percentage: json['percentage'] ?? '0',
        status: json['status'],
        amount: json['amount'] == null ? '0' : json['amount'].toString(),
        category: json['category'] ?? '',
        serviceProvider: json['providerName'] ?? '',spid: json['spid']);
  }
}
