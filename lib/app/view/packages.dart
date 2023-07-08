import 'package:carcareuser/app/model/package_model.dart';
import 'package:carcareuser/app/model/service_center_model.dart';
import 'package:carcareuser/app/view/services_view.dart';
import 'package:carcareuser/app/view_model/service_center_view_model.dart';
import 'package:carcareuser/app/view_model/services_view_model.dart';
import 'package:carcareuser/utils/global_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Packages extends StatelessWidget {
  final ServiceCenter? center;
  const Packages({Key? key, required this.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          'Packages',
          style: TextStyle(color: AppColors.appColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 25, 13, 0),
          child: Consumer<ServicesProvider>(
            builder: (context, value, _) {
              value.getPackages(center!.id!);
              return value.packages == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : value.packages!.isEmpty
                      ? const Center(child: Text('Create New packages'))
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            final package = value.packages![index];
                            return PackageTile(package: package);
                          },
                          itemCount: value.packages!.length,
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
              builder: (context) => ServicesView(center: center),
            ));
          },
          child: const Text("Create Package"),
        ),
      ),
    );
  }
}

class PackageTile extends StatelessWidget {
  const PackageTile({
    Key? key,
    required this.package,
  }) : super(key: key);

  final PackageModel package;

  @override
  Widget build(BuildContext context) {
    final serviceViewModel = Provider.of<ServiceCenterProvider>(context);

    return ExpansionTile(
      leading: TextButton.icon(
        onPressed: () async {
          final navigator = Navigator.of(context);
          serviceViewModel.selectedPackages = package;
          /*await context
              .read<ServiceCenterProvider>()
              .getSingleCenter(package.sid!);*/
          navigator.pop();
        },
        icon: const Icon(CupertinoIcons.check_mark),
        label: const Text('add'),
      ),
      title: Text(package.name ?? ""),
      subtitle: Text(package.price ?? ""),
      children: package.services!.map((e) => Text(e)).toList(),
    );
  }
}
