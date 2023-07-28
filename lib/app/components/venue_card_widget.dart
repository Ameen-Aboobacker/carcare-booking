import 'package:flutter/material.dart';

import '../../utils/global_colors.dart';
import '../../utils/global_values.dart';
import '../model/service_center_model.dart';

class VenueCardWidget extends StatelessWidget {
  final ServiceCenter? center;
  final bool isPackage;
  final String? image;
  const VenueCardWidget({
    this.center,
    super.key,
    this.isPackage = false,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: SizedBox(
        width: 150,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_imageContainer(), AppSizes.kHeight10, _venueDetails()],
          ),
        ),
      ),
    );
  }

  Widget _venueDetails() {
    return Column(
      children: [
        Center(
          child: Text(
            center?.name??'',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        AppSizes.kHeight20,
        isPackage ? const Text('') : Text('${center?.place} , ${center?.district}'),
      ],
    );
  }

  Container _imageContainer() {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.lightGrey,
        image: image != null
            ? DecorationImage(
                image: NetworkImage(image!),
                fit: BoxFit.cover,
              )
            : const DecorationImage(
                image: AssetImage('assets/newlogo.png'),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
