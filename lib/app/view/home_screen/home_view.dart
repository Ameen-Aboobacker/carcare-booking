import 'package:carcareuser/app/view_model/user_profile_provider.dart';
import 'package:carcareuser/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/global_colors.dart';
import '../../components/appbar_location.dart';
import '../../components/home_components/home_header_section.dart';
import '../../components/home_components/home_service_center.dart';


class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<UserProfileProvider>().getUserData();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: const AppBarLocation(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.12,
              child: const  HomeHeaderSection(),
            ),
          
            const HomeCenterWidget(),
            AppSizes.kHeight20,
          ],
        ),
      ),
    );
  }
}
