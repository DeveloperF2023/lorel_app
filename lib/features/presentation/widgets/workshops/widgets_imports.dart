import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:school_test_online/core/routes/routes.dart';
import 'package:school_test_online/core/utils/helpers/date_utils.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:school_test_online/features/domain/entities/workshop/workshop_entity.dart';
import 'package:school_test_online/features/presentation/widgets/global/widgets_imports.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../manager/workshops/get_workshops/get_workshops_cubit.dart';

part 'detail_workshop_content.dart';
part 'learn_more_button.dart';
part 'select_date.dart';
part 'workshop_content.dart';
