import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/global_values.dart';
import '../shimmer_widget.dart';

class BookingLoadingWidget extends StatelessWidget {
  const BookingLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            AppSizes.kHeight20,
            ListView.separated(
              itemCount: 4,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) =>
                  AppSizes.kHeight10,
              itemBuilder: (BuildContext context, int index) {
                return ShimmerWidget(
                  height: 120.h,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            BlankContainer(
                              height: 20,
                              width: 65.w,
                            ),
                            BlankContainer(
                              height: 20,
                              width: 65.w,
                            ),
                            AppSizes.kHeight20
                          ],
                        ),
                        BlankContainer(
                          height: 20,
                          width: 20.w,
                          radius: 0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            BlankContainer(
                              height: 20.h,
                              width: 65.w,
                            ),
                            BlankContainer(
                              height: 20.h,
                              width: 65.w,
                            ),
                             AppSizes.kHeight20
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
