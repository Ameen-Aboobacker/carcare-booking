import 'dart:developer';

import 'package:carcareuser/app/view_model/booking_slot_view_model.dart';
import 'package:carcareuser/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/global_colors.dart';

class DateContainerWidget extends StatelessWidget {
  const DateContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingSlotViewModel>();
    final bookedDate =
       booking.selectedDate!=null? DateFormat('d/M/y , EEEE').format(booking.selectedDate!):null;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.075,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
              height: size.height,
              width: size.width,
              color:AppColors.appColorlight,
              child: Padding(
                padding: const EdgeInsets.only(left:30,top:20),
                child: booking.selectedDate == null
                    ? Text('Pick a date',style:AppTextStyles.textH2)
                    : Text("$bookedDate",style:AppTextStyles.textH3,),
              )),
          IconButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.parse('2023-07-16'),
                firstDate: DateTime.parse('2023-07-16'),
                lastDate: DateTime.now().add(const Duration(days: 40)),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: AppColors.appColor,
                      buttonTheme: const ButtonThemeData(
                        textTheme: ButtonTextTheme.primary,
                        buttonColor: AppColors.appColor,
                      ),
                      colorScheme:
                          const ColorScheme.light(primary: AppColors.appColor)
                              .copyWith(secondary: AppColors.appColor),
                    ),
                    child: child!,
                  );
                },
              ).then((selectedDate) {
                if (selectedDate != null) {
                  booking.setDate(
                    selectedDate,
                  );
                }
              });
            },
            icon: const Icon(Icons.calendar_month_outlined, size: 30,color:AppColors.appColor),
          ),
        ],
      ),
    );
  }

  Widget _dateContainer(int index, BuildContext context, Size size) {
    const TextStyle dateStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
    final dates = setDate();
    return GestureDetector(
      onTap: () {
        log('date:${dates[index + 2]}');
      },
      child: Container(
        width: size.width * 0.15,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.black,
          ),
          borderRadius: BorderRadius.circular(6),
          color: AppColors.appColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat('MMM').format(dates[index + 2]),
                style: dateStyle,
              ),
              Text(
                dates[index + 2].day.toString(),
                style: dateStyle,
              ),
              Text(
                DateFormat('EEE').format(dates[index + 2]).toUpperCase(),
                style: dateStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DateTime> setDate() {
    final selectedDate = DateTime.now();
    List<DateTime> dates = [];
    for (int i = 0; i < 15; i++) {
      dates.add(selectedDate.add(Duration(days: i)));
    }

    return dates;
  }
}
