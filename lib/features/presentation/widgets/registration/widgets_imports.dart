import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:school_test_online/core/utils/helpers/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/routes/routes.dart';
import '../../../data/models/user/requests_register_model.dart';
import '../../manager/user/register_user/register_user_cubit.dart';
import '../global/widgets_imports.dart';

part 'registration_form.dart';
