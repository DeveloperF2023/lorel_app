import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/features/presentation/manager/user/update_profile/update_profile_cubit.dart';
import 'package:school_test_online/features/presentation/manager/user/upload_avatar/upload_avatar_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/helpers/locale_service.dart';
import '../../../../dependencies_injection.dart';
import '../../manager/lives/get_lives/get_lives_cubit.dart';
import '../global/widgets_imports.dart';

part 'home_content.dart';
