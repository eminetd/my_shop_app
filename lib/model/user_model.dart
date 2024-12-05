class UserModel {
  String? uid;
  String? email;
  String? fullname;
  String? pincode;

  UserModel({this.uid, this.email, this.fullname, this.pincode});

  //data from server
  factory UserModel.froMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullname: map['fullname'],
      pincode: map['pincode'],
    );
  }

  //sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullname': fullname,
      'pincode': pincode,
    };
  }
}
