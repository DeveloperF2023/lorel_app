import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pdfx/pdfx.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/core/routes/routes.dart';
import 'package:school_test_online/core/utils/helpers/helper_functions.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';

import '../../../../core/utils/helpers/request_handler.dart';
import 'custom_shimmer_loading.dart';

part 'audio_widget.dart';
part 'conversations_content.dart';
part 'detail_message_content.dart';
part 'show_document_picked.dart';
part 'show_image_picked.dart';
part 'show_image_selected.dart';
