class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String accountType;
  final String gender;

  UserModel(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.accountType,
      required this.gender});

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      accountType: json['accountType'],
      gender: json['gender']);
  Map<String, dynamic> toMap() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "accountType": accountType,
        "gender": gender,
      };
}
