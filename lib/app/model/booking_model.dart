class Booking{
  String? id;
  String? userId;
  String? sId;
  String? package;
  String? bookedDate;
  String? date;
  String? car;
  String? status='pending';

  Booking(
    {this.id,
    this.bookedDate,
    this.userId,
    this.date,
    this.package,
    this.car,
    this.sId,
    this.status,}
  );

  toMap(){
    return{
      'id':id,
      'sid':sId,
      'uid':userId,
      'package':package,
      'car':car,
      'bookedDate':bookedDate,
       'date':date,
       'status':status,
        
    };
    
  }
}