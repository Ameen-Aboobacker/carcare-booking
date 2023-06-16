import 'package:carcareuser/app/components/profile_components/settings.dart.dart';
import 'package:carcareuser/app/view_model/bottom_nav_view_model.dart';
import 'package:carcareuser/app/view_model/user_profile_view_model.dart';
import 'package:carcareuser/utils/session_controller.dart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/routes/navigations.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileSettings(
          title: "My Bookings",
          subtitle: "View all your bookings",
          icon: Icons.calendar_month,
          onTap: () {
            // Navigator.pushNamed(context, NavigatorClass.myBookingsView);
          },
        ),
        ProfileSettings(
          title: "My Wallet",
          subtitle: "Wallet balance: ",
          icon: Icons.account_balance_wallet,
          onTap: () {},
        ),
        ProfileSettings(
          title: "Help & Support",
          subtitle: "Contact us on whatsapp",
          icon: Icons.help,
          onTap: () {
            //openWhatsappChat(myMobile);
          },
        ),
        ProfileSettings(
          title: "Invite a friend",
          subtitle: "Share the Carcare App",
          icon: Icons.share,
          onTap: () {},
        ),
        ProfileSettings(
          title: "Rate us",
          subtitle: "Rate the Carcare App",
          icon: Icons.star,
          onTap: () {},
        ),
        ProfileSettings(
          title: "Logout",
          icon: Icons.logout,
          onTap: () {
           Provider.of<UserProfileViewModel>(context,listen:false).signOut(context);
          },
        ),
      ],
    );
  }



  /* void openWhatsappChat(String phoneNumber) async {
    String whatsappUrl = 'https://wa.me/$phoneNumber';
    try {
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl),
            mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      log(e.toString());
    }
  }*/
}
