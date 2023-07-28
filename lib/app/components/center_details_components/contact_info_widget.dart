import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/global_colors.dart';


class CenterContactInfo extends StatelessWidget {

  final String? contact;
  const CenterContactInfo({
    super.key, required this.contact,
  });

  @override
  Widget build(BuildContext context) {
   
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text(
              "Contact us",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.black,
              ),
            ),
            Text(
              contact??'',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Color.fromARGB(255, 90, 89, 89),
              ),
            ),
          ],
        ),
        OutlinedButton(
            onPressed: () async{
             openCaller();
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              minimumSize: MaterialStateProperty.all(const Size(40, 50)),
            ),
            child: const Icon(Icons.call)),
      ],
    );
  } // Replace this with the phone number you want to call

void openCaller() {
  final url = 'tel:$contact';

  launchUrl(Uri.parse(url));
}
}
