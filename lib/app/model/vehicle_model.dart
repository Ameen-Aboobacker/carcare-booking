class Vehicle {
  final String? brand;
  final String? model;
  final String? number;
 final  String? year;

  Vehicle({required this.brand, required this.model, required this.number, required this.year});
  toMap(){
    return {
      'Brand':brand,
      'Model':model,
      'Number':model,
      'Year':year,
    };
  }
}