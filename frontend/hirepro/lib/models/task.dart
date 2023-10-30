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
  Task(
      {this.id,this.area,
      required this.description,
      this.postedtime,
      required this.estmax,
      required this.estmin,
      required this.location,
      this.date,
      required this.latitude,
      required this.longitude,
      this.percentage,
      this.status});
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
    );
  }
}
