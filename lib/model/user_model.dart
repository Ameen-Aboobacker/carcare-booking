
class UserModel {
   String? id;
  final String name;
  final String email;
  final String phone; 
  UserModel({this.id,  required this.name, required this.email,required this.phone});
  toJson(){
    return {
      "id":id,
      "Name":name,
      "Email":email,
      "Phone":phone,
    };
  }
}