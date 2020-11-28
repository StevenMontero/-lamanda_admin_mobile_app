
//import 'pet.dart';

class UserProfile {

  String id;
  String userName;
  String email;
  String password;
  String photoUri;
  String lastName;
  String address;
  //List<Pet> petList;
  String phone; 

  UserProfile({
    this.id,
    this.userName,
    this.email,
    this.password,
    this.photoUri,
    this.lastName,
    this.address,
    //this.petList,
    this.phone
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
    UserProfile (
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      photoUri: json['photoUri'],
      lastName: json['lastName'],
      address: json['address'],
      //petList: json['id'];
      phone: json['phone']
      );
  
  Map<String, dynamic> toJson(){
    return {
      'id': this.id,
      'userName': this.userName,
      'email': this.email,
      'password': this.password,
      'photoUri': this.photoUri,
      'lastName': this.lastName,
      'address': this.address,
      //'petList' : this.petList,
      'phone': this.phone
    };
  }

}