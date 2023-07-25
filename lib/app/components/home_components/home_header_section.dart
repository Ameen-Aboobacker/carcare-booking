import 'package:carcareuser/app/view_model/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../model/user_profile_data_modle.dart';
//import '../../view_model/user_profile_provider.dart';


class HomeHeaderSection extends StatelessWidget {

  const HomeHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
 final UserProfileDataModel? userData= context.watch<UserProfileProvider>().userProfileData;
    return userData==null?const SizedBox():Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              AppSizes.kHeight20,
              Text(
               userData.name!=null?"Hello ${userData.name}":"Hello User",
                style:   const TextStyle(
                    color: AppColors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              AppSizes.kHeight10,
              const Text(
                "Choose your service ",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ],
          ),
        ),
       
      ],
    );
  }
}
