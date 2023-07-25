import 'package:flutter/material.dart';

import '../../../utils/global_colors.dart';


enum BookingItem { allBookings, pendings, completed }

class BookingsPopUpButton extends StatelessWidget {
  const BookingsPopUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    BookingItem? bookingItem;
    return PopupMenuButton<BookingItem>(
      initialValue: bookingItem,
      onSelected: (value) {
        bookingItem = value;
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: BookingItem.allBookings,
          child: const Text("All"),
          onTap: () {
            //bookingViewModel.setSelectedPopUp("all");
          },
        ),
        PopupMenuItem(
          value: BookingItem.pendings,
          child: const Text("Pending"),
          onTap: () { //bookingViewModel.setSelectedPopUp("pending");
          },
        ),
        PopupMenuItem(
          value: BookingItem.completed,
          child: const Text("Completed"),
          onTap: () { //bookingViewModel.setSelectedPopUp("completed");
          },
        ),
      ],
      // offset: const Offset(0, 50),
      color: AppColors.white,
      elevation: 2,
    );
  }
}
