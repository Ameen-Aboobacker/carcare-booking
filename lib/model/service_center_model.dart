
class ServiceCenterModel {
   String? id;
  final String name;
  final String email;
  final String phone; 
  final String place; 
  ServiceCenterModel( {this.id,  required this.name,required this.place, required this.email,required this.phone});
  toJson(){
    return {
      "id":id,
      "Name":name,
      "Email":email,
      "Phone":phone,
      "Place":place,
    };
  }
}