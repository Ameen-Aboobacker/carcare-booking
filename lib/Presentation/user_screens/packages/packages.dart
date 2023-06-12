import 'package:flutter/material.dart';

import '../../../utils/global_values.dart';



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
                separatorBuilder: (context, index) => AppSizes.kHeight20,
                itemCount: package.length,
              ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          
        },
        label: const Text('add packages'),
      ),
    );
  }

}