import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../widgets/text_field.dart';

class Packages extends StatefulWidget {
  const Packages({Key? key}) : super(key: key);

  @override
  State<Packages> createState() => _PackagesState();
}

List package = [];
List services=['water service -100rs','oil change -100rs','custom service-500rs'];

class _PackagesState extends State<Packages> {
  final TextEditingController nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          'Your packages',
          style: TextStyle(color: Colors.purple),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: package.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(child: Text('no packages added')),
                ],
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  Map car = package[index];
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
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => kHeight15,
                itemCount: package.length,
              ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          modalBottomSheet(context);
        },
        label: const Text('add packages'),
      ),
    );
  }

  Future<dynamic> modalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
          backgroundColor: Colors.purple,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          context: context,
          builder: (context) {
            return ListView(
              children: [
                const Text('Create Your Own Package'),
                TextFieldWidget(
                  controller: nameCtrl,
                  labelText: 'Name ',
                  keyType: TextInputType.name,
                  icon: Icons.local_offer,
                ),
                 DropdownButtonFormField(
              borderRadius: BorderRadius.circular(20),
              hint: const Text('Blood group'),
              items: services
                  .map(
                    (e) => DropdownMenuItem(value: e, child: Text(e)),
                  )
                  .toList(),
              onChanged: (value) {
               // selgroup=value as String?;
              }),
              ],
            );
          },
        );
  }
}
