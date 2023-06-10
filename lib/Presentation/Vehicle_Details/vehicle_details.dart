import 'package:carcareuser/Presentation/widgets/submit_button.dart';
import 'package:carcareuser/Presentation/widgets/text_field.dart';
import 'package:carcareuser/core/constants.dart';
import 'package:carcareuser/model/vehicle_model.dart';
import 'package:flutter/material.dart';

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({Key? key}) : super(key: key);

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

final List vehicle=[];
final TextEditingController modelCtrl = TextEditingController();
final TextEditingController brandCtrl = TextEditingController();
final TextEditingController numberCtrl = TextEditingController();
final TextEditingController yearCtrl = TextEditingController();

class _VehicleDetailsState extends State<VehicleDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          'Your Vehicles',
          style: TextStyle(color: Colors.purple),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: vehicle.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(child: Text('no vehicles added')),
                ],
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  Map car=vehicle[index];
                  return ListTile(
                
                  leading: const CircleAvatar(),
                  title: Text(car['Model']),
                  subtitle: Text(car['Brand']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                         
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );},
                separatorBuilder: (context, index) => kHeight15,
                itemCount: vehicle.length,
              ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.purple,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            context: context,
            builder: (ctx) {
              return Column(
                children: [
                  kHeight20,
                  const Text('Add Vehicle Details'),
                  kHeight20,
                  TextFieldWidget(
                    controller: brandCtrl,
                    labelText: 'Brand',
                    keyType: TextInputType.name,
                    icon: Icons.car_rental,
                  ),
                  kHeight15,
                  TextFieldWidget(
                    controller: modelCtrl,
                    labelText: 'Model',
                    keyType: TextInputType.name,
                    icon: Icons.car_rental,
                  ),
                  kHeight15,
                  TextFieldWidget(
                    controller: numberCtrl,
                    labelText: 'Vehicle Number',
                    keyType: TextInputType.number,
                    icon: Icons.car_rental,
                  ),
                  kHeight15,
                  TextFieldWidget(
                    controller: yearCtrl,
                    labelText: 'year',
                    keyType: TextInputType.number,
                    icon: Icons.car_rental,
                  ),
                  kHeight15,
                 SubmitButton(onPressed: (){
                  VehicleModel car=VehicleModel(brand: brandCtrl.text, model: modelCtrl.text, number: numberCtrl.text, year: yearCtrl.text,);
                  setState(() {
                    vehicle.add(car.toMap());
                    print(vehicle);
                  });
                 }, name: 'ADD',color: Colors.white,textColor:Colors.purple)
                ],
              );
            },
          );
        },
        label: const Text('add vehicles'),
      ),
    );
  }
}
