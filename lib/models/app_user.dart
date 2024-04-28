// user DTO

class AppUser{

  String? id;
  String? userName;
  String? email;
  String? password;
  String? phone;
  String? image;
  String? role;
  
  AppUser({
    this.id, 
    this.userName, 
    this.email, 
    this.password, 
    this.phone,
    this.image, 
    this.role,
  });

  Map<String, dynamic> toJson(){ 
    return {
      "id": id,
      "userName": userName,
      "email": email,
      "password": password,
      "phone": phone,
      "image": image,
      "role": role,
    };
  }
}