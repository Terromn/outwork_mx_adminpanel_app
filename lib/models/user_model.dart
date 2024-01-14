class UserModel {
  String name;
  String userUID;
  String profilePicture;
  int creditsAvailable;
  dynamic reservedClasses;

  UserModel({
    required this.name,
    required this.userUID,
    required this.profilePicture,
    required this.creditsAvailable,
    required this.reservedClasses,
  });
}