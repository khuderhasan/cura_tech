import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String id;
  final String userName;
  final String userEmail;
  final Timestamp createdAt;
  final String userId;
  final String contnet;

  Report(
      {required this.id,
      required this.userName,
      required this.userEmail,
      required this.createdAt,
      required this.userId,
      required this.contnet});

  factory Report.fromMap(Map<String, dynamic> json) => Report(
        id: json['id'],
        contnet: json['content'],
        userId: json['userId'],
        userName: json['userName'],
        userEmail: json['userEmail'],
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toMap() => {
        'userName': userName,
        'userEmail': userEmail,
        'createdAt': createdAt,
        'userId': userId,
        'content': contnet,
      };
}
