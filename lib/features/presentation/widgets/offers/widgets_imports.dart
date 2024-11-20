import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:school_test_online/features/presentation/manager/offers/apply_to_offer/apply_to_offer_cubit.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../manager/offers/add_to_favorite_list/add_to_favorite_list_cubit.dart';
import '../../manager/offers/favorite_status_cubit.dart';
import '../../manager/offers/get_offers_by_type/get_offers_by_type_cubit.dart';
import '../../manager/offers/remove_from_favorite_list/remove_from_favorite_list_cubit.dart';
import '../../manager/offers/search_offers/search_offers_cubit.dart';
import '../../manager/offers/toggle_offers/toggle_offers_cubit.dart';
import '../global/widgets_imports.dart';

part 'detail_offer_content.dart';
part 'favorite_content.dart';
part 'header_offers.dart';
part 'offers_content.dart';
part 'toggle_buttons_offers.dart';
