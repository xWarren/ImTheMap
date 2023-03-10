class Info {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;

  Info({this.uid, this.email, this.firstName, this.lastName});

  // receiving data from the server
  factory Info.fromMap(map) {
    return Info(
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
