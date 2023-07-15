class UserSignupModel {
  UserSignupModel({
    this.name,
    this.mobile,
    this.email,
    this.password,
    this.place,
    this.district,
    this.description,
    this.imagePath,
    this.id,
    this.services
  });

  String? name;
  String? district;
  String? place;
  String? mobile;
  String? email;
  String? password;
  String? id;
  String? imagePath;
  String? description;
  List? services;

  Map<String, dynamic> toJson() => {
        "name": name,
        "contact": mobile,
        "district": district,
        'imagePath': imagePath,
        'description': description,
        "Place": place,
        "sid": id,
        'services':services,
      };
}
