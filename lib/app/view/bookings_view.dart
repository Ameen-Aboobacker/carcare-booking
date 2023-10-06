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
    final bookingData=context.watch<MyBookingsViewModel>();
    final bookings = userData.userProfileData?.bookings;
   // print('book :$bookings true:${bookings!.isNotEmpty}');
    if(bookings!=null&&bookings.isNotEmpty){
      bookingData.getBookings(bookings);
    }
int bookingCount = bookingData.count;
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
              /*Consumer<MyBookingsViewModel>(
                  builder: (context, userProvider, _) {
                     if (bookings == null){
                      return const Center(child: Text('No bookings available'));
                     }
                    userProvider.getBookings(bookings);
                     if (userProvider.booking == null){
                      return const Center(child: CircularProgressIndicator(),);
                     }
                     else if (
                        userProvider.booking!.isEmpty) {
                      return const Center(child: Text('No bookings available'));
                    }
                    return */
                  
                  bookings==null||bookings.isEmpty? const Center(child: Text('No bookings available')):
                       Padding( 
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: bookingData.booking!.length,
                          separatorBuilder: (context, index) =>
                              AppSizes.kHeight10,
                          itemBuilder: (context, index) {
                            final booking = bookingData.booking![index];

                            return BookingCard(
                              bookingData: booking,
                            );
                          }),
                    ),
                 /* },
                ),*/
        ),
      ),
    );
  }
}
