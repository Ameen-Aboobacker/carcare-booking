import 'package:carcareuser/app/view/service_center/center_details_view.dart';
import 'package:flutter/material.dart';
import '../../utils/global_colors.dart';
import '../../utils/routes/navigations.dart';

class ServiceCenterListCardWidget extends StatelessWidget {
  const ServiceCenterListCardWidget({
    super.key,
    required this.venueName,
    required this.imageUrl,
    required this.sportFacilityLendth,
    required this.venuePrice,
    required this.district,
    required this.venueID,
  });

  final String venueName;
  final String venueID;
  final String imageUrl;
  final int sportFacilityLendth;
  final String venuePrice;
  final String district;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListTile(
      contentPadding:
          const EdgeInsets.only(top: 4, left: 8, bottom: 10, right: 20),
      tileColor: Colors.amber,
      leading: _imageContianer(),
      title: Text(
        venueName,
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
            district,
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
               
                navigator.pushNamed(NavigatorClass.venueDetailsScreen);
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
