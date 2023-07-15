import 'package:carcareuser/app/model/service_center_model.dart';
import 'package:carcareuser/app/view_model/service_center_provider.dart';
import 'package:flutter/material.dart';

import '../../../utils/global_colors.dart';


class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    super.key,
    required this.centerViewModel,
    required this.centerData,
  });

  final ServiceCenterProvider centerViewModel;
  final ServiceCenter centerData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColors.white,
      expandedHeight: size.height * 0.30,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Container(
          decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: centerViewModel.isLoading
            ? const CircularProgressIndicator()
            : Container(
                color: AppColors.lightGrey,
                child: centerData.image==null? Image.asset(
                  'assets/setting-transformed.png',
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text("Could not load image"),
                    );
                  },
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ):Image.network(
                  centerData.image!,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text("Could not load image"),
                    );
                  },
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                )
              ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          width: double.infinity,
          height: 20,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          child: Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(75, 158, 158, 158)),
            ),
          ),
        ),
      ),
    );
  }
}