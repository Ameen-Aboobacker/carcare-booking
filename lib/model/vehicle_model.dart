class VehicleModel{
  final  String brand;
   final String model;
   final String number;
   final String year;
   VehicleModel({required this.brand,required this.model,required this.number,required this.year});
   toMap(){
    return {
      'Brand':brand,
      'Model':model,
      'number':number,
      'year':year,
    };
   }
 }