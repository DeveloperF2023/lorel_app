import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/core/routes/routes.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:school_test_online/dependencies_injection.dart';
import 'package:school_test_online/features/presentation/manager/payment/manual_payment/manual_payment_cubit.dart';
import 'package:school_test_online/features/presentation/widgets/global/widgets_imports.dart';

import '../../manager/payment/get_rib/get_rib_cubit.dart';

part 'payment_content.dart';
