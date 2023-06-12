import 'package:flutter/material.dart';


import '../../.core/constants.dart';



class MainCard extends StatelessWidget {
  const MainCard({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 250,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: kradius,
          image:  DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
