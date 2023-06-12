import 'package:flutter/material.dart';
import '../../../model/profile/settings.dart';
import '../../../model/profile/tile.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Text("Profile", style: AppTextStyles.appbarTitle),
      ),
      body: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          UserProfileContainer(),
                          AppSizes.kHeight20,
                          SettingsListTile()
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
