

import 'package:carcareuser/app/view_model/user_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/profile_components/settings_tile.dart';
import '../../components/profile_components/user_profile_tile.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
  final userDataModel = context.watch<UserProfileViewModel>();
  
 
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Text("Profile", style: AppTextStyles.appbarTitle),
      ),
      body:userDataModel.userProfileData==null?
      const Center(child:CircularProgressIndicator()) 
      :Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserProfileContainer(userProfile: userDataModel.userProfileData!),
                AppSizes.kHeight20,
                const SettingsListTile()
              ],
            ),
            const Text(
              "Version 1.0.0",
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
