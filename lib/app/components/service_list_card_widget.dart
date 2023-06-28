import 'package:carcareuser/app/model/service_center_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/global_colors.dart';
import '../../utils/routes/navigations.dart';
import '../view_model/center_list_view_model.dart';

class ServiceCenterListCardWidget extends StatelessWidget {
  const ServiceCenterListCardWidget({
    super.key,
    required this.centerName,
    required this.imageUrl,
    required this.place,
    required this.center,
    required this.district,
  });

  final String centerName;
  final ServiceCenter center;

  final String imageUrl;
  final String place;
  final String district;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.only(top: 4, left: 8, bottom: 10, right: 20),
      tileColor: Colors.amber,
      leading: _imageContianer(),
      title: Text(
        centerName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Row(
        children: [
          const Icon(
            Icons.location_on,
            size: 17,
            color: AppColors.appColor,
          ),
          Text(
            '$place,$district',
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.lightBlack),
          ),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: SizedBox(
          height: 30,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(elevation: 0),
            onPressed: () async {
            final navigator = Navigator.of(context);
        await context.read<CenterDetailsViewModel>().getSingleVenue(center.id!);
        navigator.pushNamed(NavigatorClass.centerDetailsView);
            },
            child: const Text("View"),
          ),
        ),
      ),
    );
  }

  Container _imageContianer() {
    return Container(
      height: 90,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.lightGrey,
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
