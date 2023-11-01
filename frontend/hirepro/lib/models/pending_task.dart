class PendingTask {
  String id;
  String? area;
  String? description;
  String? postedtime;
  String estmin;
  String estmax;
  String location;
  String? date;
  String latitude;
  String longitude;
  String? category;
  PendingTask(
      {required this.id,
      this.area,
      required this.description,
      this.postedtime,
      required this.estmax,
      required this.estmin,
      required this.location,
      this.date,
      required this.latitude,
      required this.longitude,this.category});
  factory PendingTask.fromJson(Map<String, dynamic> json) {
    return PendingTask(
      id: json['id'],
      area: json['area'],
      description: json['description'],
      latitude: json['latitude'] != null ? json['latitude'] : null,
      longitude: json['longitude'] != null ? json['longitude'] : null,
      estmax: json['estmax'].toString(),
      estmin: json['estmin'].toString(),
      postedtime: json['posted_timestamp'],
      location: json['location'],
      date: json['date'],
      category: json['category'],
    );
  }
}
