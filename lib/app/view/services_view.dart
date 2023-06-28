import 'dart:developer';

import 'package:carcareuser/app/model/service_center_model.dart';
import 'package:carcareuser/user_registration/components/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/center_list_view_model.dart';
import '../view_model/services_view_model.dart';

class ServicesView extends StatelessWidget {
  final String? centerId;
  const ServicesView({super.key, required this.centerId});

  @override
  Widget build(BuildContext context) {
    
    // print(centerData.services.toString());
   
        
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      body: Consumer<ServicesViewModel>(
        builder: (context, optionsProvider, _) {
         optionsProvider.setOptions(context);
          return ListView.builder(
            itemCount: optionsProvider.options!.length,
            itemBuilder: (context, index) {
              final option = optionsProvider.options![index];

              return CheckboxListTile(
                title: Text(option.name),
                subtitle: Text(option.rate),
                value: option.isSelected,
                onChanged: (value) {
                  optionsProvider.toggleOption(index);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final optionsProvider =
              Provider.of<ServicesViewModel>(context, listen: false);
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
                    controller: pnameCtrl,
                    textFieldIcon: Icons.title,
                    keyType: TextInputType.name),
                ElevatedButton(
                    onPressed: () {
                      optionsProvider.createPackage(context, centerId);
                    },
                    child: const Text('create'))
              ],
            ),
          );
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
