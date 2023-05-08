class UserModel{
  String? email;
  String? name;
  String? image;
  String? uId;
  bool? emailVerify;

  UserModel({this.email,this.name,this.uId,this.emailVerify,this.image});

  UserModel.fromJson(Map<String,dynamic> json){
    email = json['email'];
    name = json['name'];
    image = json['image'];
    uId = json['uId'];
    emailVerify = json['isEmailVerify'];
  }

  Map<String,dynamic> toMap(){
    return {
      'email' : email,
      'name' : name,
      'image' : image,
      'uId' : uId,
      'isEmailVerify' : emailVerify,
    };
  }
}