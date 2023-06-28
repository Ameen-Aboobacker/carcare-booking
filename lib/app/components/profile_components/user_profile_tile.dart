import 'package:carcareuser/app/model/user_profile_data_modle.dart';
import 'package:flutter/material.dart';

//import 'package:sporter_turf_booking/home/model/user_profile_data_modle.dart';

import '../../../../utils/global_colors.dart';
import '../../../../utils/global_values.dart';
class UserProfileContainer extends StatelessWidget {
  final UserProfileDataModel? userProfile;
  const  UserProfileContainer({
    super.key, required this.userProfile,
    
  });
  
  
  @override
  Widget build(BuildContext context) {
  
    return  Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: AppColors.appColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.white,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/no_user.png"),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:    [
                Text(
                userProfile!.name??'name',
                style:  const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
               userProfile!.email??'12356',
                style:  const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            ],
          ),
          AppSizes.kWidth25,
          AppSizes.kWidth25,
        ],
      ),
    );
  }
}