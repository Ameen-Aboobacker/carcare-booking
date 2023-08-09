import 'dart:developer';

import 'package:carcareuser/app/model/service_center_model.dart';
import 'package:carcareuser/user_registrations/components/text_form_field.dart';
import 'package:carcareuser/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/services_provider.dart';

class ServicesView extends StatelessWidget {
  final ServiceCenter center;
  const ServicesView({super.key, required this.center});

  @override
  Widget build(BuildContext context) {
    final sp = context.read<ServicesProvider>();
    sp.getServices(center.service!);
    log('length:${center.service!.length.toString()}');
    log('length:${sp.services!.length}');

    // print(centerData.services.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      
      ),
      body: sp.services == null
          ? const Center(child: CircularProgressIndicator())
          : Consumer<ServicesProvider>(
            builder: (context,service,_) {
              return ListView.builder(
                  itemCount: sp.services!.length,
                  itemBuilder: (context, index) {
                    log(sp.services!.length.toString());
                    final option = sp.services![index];
                    return ListTile(
                      title: Text(option.name??''),
                      subtitle: Text(option.rate!),
                      trailing: Checkbox(
                        value: option.isSelected,
                        onChanged: (value) {
                          Provider.of<ServicesProvider>(context,listen: false).toggleOption(option);
                        },
                      ),
                    );
                  },
                );
            }
          ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.appColor,
        onPressed: () {
          final optionsProvider =
              Provider.of<ServicesProvider>(context, listen: false);
          final pnameCtrl = optionsProvider.packageNameCtrl;
          optionsProvider.getSelectedOptions();
          final selectedOptions = optionsProvider.selectedOptions;
          print(selectedOptions);
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              title: const Text("Package Name"),
              children: [
                TextFormWidget(
                    labelText: 'package name',
                    controller: pnameCtrl,
                    textFieldIcon: Icons.title,
                    keyType: TextInputType.name),
                ElevatedButton(
                    onPressed: () {
                      optionsProvider.createPackage(context, center.id);
                    },
                    child: const Text('create'))
              ],
            ),
          );
        },
        label:Text('create'),
      ),
    );
  }
}
