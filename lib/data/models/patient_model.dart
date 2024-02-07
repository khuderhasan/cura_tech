class Patient {
  final String id;
  final String fullName;
  final String healthStatus;
  final String email;
  final double? lat;
  final double? long;
  Patient(
      {required this.id,
      required this.fullName,
      required this.healthStatus,
      required this.email,
      this.lat,
      this.long});
  factory Patient.fromMap(Map<String, dynamic> json) => Patient(
      id: json['id'],
      fullName: json['fullName'],
      healthStatus: json['healthStatus'],
      email: json['email'],
      lat: json['lat'],
      long: json['long']);
  Map<String, dynamic> toMap() => {
        "id": id,
        "fullName": fullName,
        "healthStatus": healthStatus,
        "email": email,
        "lat": lat,
        "long": long,
      };
}
