import 'dart:developer';

import 'package:carcareuser/app/components/profile_components/settings.dart.dart';
import 'package:carcareuser/app/view_model/bottom_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../view_model/user_profile_provider.dart';

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
            context.read<BottomBarProvider>().bottomOnChanged(3);
          },
        ),
        ProfileSettings(
          title: "Help & Support",
          subtitle: "Contact us on whatsapp",
          icon: Icons.help,
          onTap: () {
            openWhatsappChat('8606044404');
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
            context.read<UserProfileProvider>().signOut(context);
          },
        ),
      ],
    );
  }

  void openWhatsappChat(String phoneNumber) async {
    String whatsappUrl = 'https://wa.me/91$phoneNumber';
    try {
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl),
            mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
