import 'package:carcareuser/user_registrations/components/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/profile_components/settings_tile.dart';
import '../../components/profile_components/user_profile_tile.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';
import '../../view_model/user_profile_provider.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileviewmodel = Provider.of<UserProfileProvider>(context,listen: false);
 
    final userProfileData = profileviewmodel.userProfileData;
       if (userProfileData!=null) {
       }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Text("Profile", style: AppTextStyles.appbarTitle),
      ),
      body:userProfileData == null 
          ? const Center(child: CircularProgressIndicator()):
          userProfileData.isEmpty()
         ? Center(
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const UpdateProfile();
                            });
                      },
                      child: const Text('UPDATE YOUR PROFILE')))
              :  Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserProfileContainer(userProfile: userProfileData),
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

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final updateView = context.read<UserProfileProvider>();
    return SimpleDialog(
      title: Text('Add details', style: AppTextStyles.loginHeading),
      children: [
        TextFormWidget(
          labelText: '',
          controller: updateView.nameCtrl,
          textFieldIcon: Icons.abc,
          keyType: TextInputType.name,
        ),
        TextFormWidget(
          labelText: '',
          controller: updateView.mailCtrl,
          textFieldIcon: Icons.abc,
          keyType: TextInputType.emailAddress,
        ),
        TextFormWidget(
          labelText: '',
          controller: updateView.phoneCtrl,
          textFieldIcon: Icons.abc,
          keyType: TextInputType.phone,
        ),
        OutlinedButton(
            onPressed: () {
              updateView.updateData(context);
            },
            child: const Text('update'))
      ],
    );
  }
}
