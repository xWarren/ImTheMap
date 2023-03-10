class UserClass {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String image = "https://i.ibb.co/K0kX5hD/user-icon.jpg";
  String guest_image = "https://i.ibb.co/Q6y86CM/no-profile.webp";

  UserClass({this.uid, this.email, this.firstName, this.lastName});

  // receiving data from the server
  factory UserClass.fromMap(map) {
    return UserClass(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }

  // sending the data from server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
