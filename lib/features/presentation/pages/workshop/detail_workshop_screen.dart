import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/core/utils/helpers/helper_functions.dart';

import '../../../../dependencies_injection.dart';
import '../../manager/workshops/get_detail_workshop/get_detail_workshop_cubit.dart';
import '../../widgets/workshops/widgets_imports.dart';

class DetailWorkshopScreen extends StatelessWidget {
  final int workshopId;
  const DetailWorkshopScreen({super.key, required this.workshopId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: HelperFunctions.screenHeight(context),
        width: HelperFunctions.screenWidth(context),
        decoration: BoxDecoration(gradient: AppColors.workshopGradient),
        child: SafeArea(
            child: BlocProvider(
          create: (context) => locator<GetDetailWorkshopCubit>()
            ..getWorkshopsById(workshopId: workshopId),
          child: BlocBuilder<GetDetailWorkshopCubit, GetDetailWorkshopState>(
            builder: (context, state) {
              if (state is GetDetailWorkshopLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryColor));
              } else if (state is GetDetailWorkshopLoaded) {
                final workshop = state.workshop;
                return DetailWorkshopContent(
                  workshop: workshop,
                );
              } else if (state is GetDetailWorkshopFailure) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        )),
      ),
    );
  }
}
