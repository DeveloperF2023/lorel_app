import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/constants/app_assets.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/core/routes/routes.dart';
import 'package:school_test_online/core/utils/helpers/validators.dart';
import 'package:school_test_online/features/presentation/pages/language/language_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/utils/helpers/locale_service.dart';
import '../../../../main.dart';
import '../../manager/user/credential/credential_cubit.dart';
import '../global/widgets_imports.dart';

part 'form_auth.dart';
part 'login_content.dart';
