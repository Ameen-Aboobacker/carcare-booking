

import 'package:flutter/material.dart';



import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../view/payment_proceed_view.dart';


class BookingSlotBottomBar extends StatelessWidget {
  const BookingSlotBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
 
    return Container(
      width: double.infinity,
      height: 70,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color.fromARGB(67, 158, 158, 158),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
         AppSizes.kHeight10,
            SizedBox(
              height: 44,
              width: 100,
              child: ElevatedButton(
                onPressed: 
                    () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProceedPayView(),));
                      }
                  ,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  disabledBackgroundColor: AppColors.lightGrey,
                ),
                child: const Text("NEXT"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
