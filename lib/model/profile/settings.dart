
import 'package:carcareuser/model/profile/view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../user_registration/view_model/firebase_auth_view_model.dart';


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
          
                  context
                      .read<FirebaseAuthViewModel>()
                      .userLoginStatus(context);
                 
                
          },
        ),
        // ProfileSettings(
        //   title: "Delete My Account",
        //   icon: Icons.delete_forever,
        //   onTap: () {},
        // ),
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