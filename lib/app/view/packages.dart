import 'package:carcareuser/app/model/package_model.dart';
import 'package:carcareuser/app/model/service_center_model.dart';
import 'package:carcareuser/app/view/services_view.dart';
import 'package:carcareuser/app/view_model/booking_provider.dart';
import 'package:carcareuser/app/view_model/services_provider.dart';
import 'package:carcareuser/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Packages extends StatelessWidget {
  final ServiceCenter? center;
  const Packages({Key? key, required this.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final s=Provider.of<ServicesProvider>(context);
     final booking=Provider.of<BookingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          'Packages',
          style: TextStyle(color: AppColors.appColor),
        ),
        centerTitle: true,
        actions: [
          s.selectedPackages==null?
          const SizedBox()
          :IconButton(onPressed: (){
            booking.setPackages(s.selectedPackages!);
            Navigator.pop(context);

          }, icon: const Icon(Icons.done_outlined))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 25, 13, 0),
          child: Consumer<ServicesProvider>(
            builder: (context, serviceProvider, _) {
              serviceProvider.getPackages(center!.id!);
              return serviceProvider.packages == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : serviceProvider.packages!.isEmpty
                      ? const Center(child: Text('Create New packages'))
                      : Column(
                          children: serviceProvider.packages!.map((service) {
                            return RadioListTile<PackageModel>(
                              title: Text(service.name!),
                              subtitle: Text(service.price!),
                              value: service,
                              groupValue: serviceProvider.selectedPackages,
                              onChanged: (value) {
                                if (value == serviceProvider.selectedPackages) {
                                  serviceProvider.setPackages(null);
                                } else {
                                  serviceProvider.setPackages(value!);
                                }
                              },
                            );
                          }).toList(),
                        );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 45,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ServicesView(center: center!),
            ));
          },
          child: const Text("Create Package"),
        ),
      ),
    );
  }
}

/*class PackageTile extends StatelessWidget {
  const PackageTile({
    Key? key,
    required this.package,
    required this.provider,
  }) : super(key: key);

  final PackageModel package;
  final ServicesProvider provider;

  @override
  Widget build(BuildContext context) {
 

    /* RadioListTile(
      title: Text(package.name ?? ""),
      subtitle: Text(package.price ?? ""),
        serviceProvider: package,
        groupserviceProvider:provider.selectedPackages,
        onChanged: (serviceProvider){
          provider.setPackages(serviceProvider!) ;
        },
      
      // children: package.services!.map((e) => Text(e)).toList(),
    );*/
  }
}*/
