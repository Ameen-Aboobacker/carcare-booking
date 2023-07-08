
import 'package:carcareuser/app/model/service_center_model.dart';
import 'package:carcareuser/user_registration/components/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/services_view_model.dart';

class ServicesView extends StatelessWidget {
  final ServiceCenter? center;
  const ServicesView({super.key, required this.center});

  @override
  Widget build(BuildContext context) {
    
    // print(centerData.services.toString());
   
        
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      body: Consumer<ServicesProvider>(
        builder: (context, optionsProvider, _) {
         optionsProvider.setOptions(context,center!.services);
         if(optionsProvider.options==null){
          return const Center(child:CircularProgressIndicator());
         }
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
                    controller: pnameCtrl,
                    textFieldIcon: Icons.title,
                    keyType: TextInputType.name),
                ElevatedButton(
                    onPressed: () {
                      optionsProvider.createPackage(context, center!.id);
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
