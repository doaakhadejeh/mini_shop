import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String? phoneNumber;
  final String? displayName;

  UserModel({required this.uid, this.phoneNumber, this.displayName});

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      phoneNumber: user.phoneNumber,
      displayName: user.displayName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'phoneNumber': phoneNumber, 'displayName': displayName};
  }
}
