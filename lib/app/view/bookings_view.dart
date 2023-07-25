import 'package:carcareuser/app/view_model/my_booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/global_colors.dart';
import '../../utils/global_values.dart';
import '../components/bookings_components/booking_card.dart';
import '../view_model/user_profile_provider.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserProfileProvider>();

    final bookings = userData.userProfileData?.bookings;
    int bookingCount = bookings?.length ?? 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: Text(
          "Bookings($bookingCount)",
          style: const TextStyle(
            color: AppColors.white,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.appColor,
              Color.fromARGB(201, 108, 103, 211),
              Color.fromARGB(255, 171, 168, 214),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: SafeArea(
          child:
              Consumer<MyBookingsViewModel>(
                  builder: (context, userProvider, _) {
                    userProvider.getBookings(bookings!);
                     if (userProvider.booking == null){
                      return const Center(child: CircularProgressIndicator(),);
                     }
                     else if (
                        userProvider.booking!.isEmpty) {
                      return const Center(child: Text('No bookings available'));
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: userProvider.booking!.length,
                          separatorBuilder: (context, index) =>
                              AppSizes.kHeight10,
                          itemBuilder: (context, index) {
                            final booking = userProvider.booking![index];

                            return BookingCard(
                              bookingData: booking,
                            );
                          }),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
