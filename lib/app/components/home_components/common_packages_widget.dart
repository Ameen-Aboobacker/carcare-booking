import 'package:flutter/material.dart';
import 'home_components.dart';
import '../venue_card_widget.dart';

class CommonPackagesWidget extends StatelessWidget {
  const CommonPackagesWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
  

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     const  Padding(
        padding:  EdgeInsets.only(left:10,bottom: 15),
        child: Text(
              'Top Packages',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
      ),
      SizedBox(
        width: size.width,
        height: size.height * 0.25,
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: VenueCardWidget( name: 'statndard',isPackage: true,),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
