import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/core/utils/helpers/helper_functions.dart';

import '../../../../core/utils/helpers/locale_service.dart';
import '../../../domain/entities/courses/courses_by_status_entity.dart';
import '../../manager/courses/get_courses_by_status/get_courses_by_status_cubit.dart';
import '../../manager/courses/toggle_buttons/toggle_buttons_cubit.dart';

part 'back_my_courses.dart';
part 'custom_alert_dialog.dart';
part 'my_courses_content.dart';
part 'my_courses_not_found.dart';
part 'toggle_buttons_widget.dart';
