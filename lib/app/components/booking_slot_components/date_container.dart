import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';


class DateContainerWidget extends StatelessWidget {
  const DateContainerWidget({
    super.key,
  });

  // @override
  @override
  Widget build(BuildContext context) {
  
   

    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.075,
      width: double.infinity,
      child: Row(
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => AppSizes.kWidth5,
            itemBuilder: (context, index) {
              return _dateContainer(index, context, size);
            },
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 15)),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: AppColors.appColor,
                        buttonTheme: const ButtonThemeData(
                            textTheme: ButtonTextTheme.primary,
                            buttonColor: AppColors.appColor),
                        colorScheme:
                            const ColorScheme.light(primary: AppColors.appColor)
                                .copyWith(secondary: AppColors.appColor),
                      ),
                      child: child!,
                    );
                  },
                ).then((selectedDate) {
                 /* if (selectedDate != null) {
                    bookingViewModel.setDate(
                      selectedDate,
                      venueViewModel.venueData.sId,
                    );
                    venueViewModel.getDayIndex(DateFormat('EEEE')
                        .format(bookingViewModel.selectedDate!));
                  }*/
                });
              },
              icon: const Icon(Icons.calendar_month_outlined, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateContainer(index, BuildContext context, Size size) {
   
   

    return GestureDetector(
      onTap:  () {
             
            },
      child: Container(
        width: size.width * 0.15,
        decoration: BoxDecoration(
          border: Border.all(
            color:AppColors.black,
          ),
          borderRadius: BorderRadius.circular(6),
          color: AppColors.appColor
              
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            
            ],
          ),
        ),
      ),
    );
  }
}
