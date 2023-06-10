import 'package:flutter/material.dart';
import '../../../utils/global_colors.dart';

class ProfileSettings extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final GestureTapCallback? onTap;
  const ProfileSettings({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading:  CircleAvatar(
        backgroundColor:const Color.fromARGB(51, 148, 219, 148),
        radius: 17,
        child: Icon(
          icon,
          color: AppColors.appColor,
          size: 20,
        ),
      ),
      title:  Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      subtitle: subtitle != null?  Text(
       subtitle!,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
      ): null,
      trailing: const Icon(Icons.keyboard_arrow_right),
    );
  }
}