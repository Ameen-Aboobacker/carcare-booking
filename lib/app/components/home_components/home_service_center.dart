import 'package:carcareuser/app/model/service_center_model.dart';
import 'package:carcareuser/app/view_model/service_center_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carcareuser/app/view_model/bottom_nav_view_model.dart';
import '../../../utils/global_values.dart';
import '../venue_card_widget.dart';
import 'home_components.dart';

class HomeCenterWidget extends StatelessWidget {
  const HomeCenterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final List<ServiceCenter> userData= context.watch<ServiceCenterProvider>().serviceCenterList;
    final size = MediaQuery.of(context).size;
    return Column(children: [
      HomeComponents.viewAllText(
        lText: "Centers",
        onPressed: () {
          context.read<BottomBarProvider>().changeBottomNavindex(2);
        },
      ),
      AppSizes.kHeight20,
      SizedBox(
        height: size.height * 0.25,
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: userData.length > 5 ? 5 : userData.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  ServiceCenter center=userData[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: VenueCardWidget(
                      image:center.image,
                      name: center.name!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
