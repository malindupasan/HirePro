class Task {
  String? area;
  String description;
  String? postedtime;
  String estmin;
  String estmax;
  String location;
  String? date;
  String latitude;
  String longitude;
  Task(
      {this.area,
      required this.description,
      this.postedtime,
      required this.estmax,
      required this.estmin,
      required this.location,
      this.date,
      required this.latitude,
      required this.longitude});
}
