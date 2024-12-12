import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdfx/pdfx.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:school_test_online/features/presentation/widgets/global/widgets_imports.dart';

import '../../../../core/utils/helpers/request_handler.dart';

class ReadPdfScreen extends StatefulWidget {
  final String title;
  final String pdfUrl;
  const ReadPdfScreen({super.key, required this.title, required this.pdfUrl});

  @override
  State<ReadPdfScreen> createState() => _ReadPdfScreenState();
}

class _ReadPdfScreenState extends State<ReadPdfScreen> {
  PdfController? _pdfController;
  bool _loading = true;
  String? _errorMessage;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _fetchPdf();
  }

  Future<void> _fetchPdf() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        widget.pdfUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      final Uint8List data = response.data as Uint8List;

      if (mounted) {
        setState(() {
          _pdfController = PdfController(
            document: PdfDocument.openData(data),
          );
          _loading = false;
        });
      }
    } catch (e) {
      print('Error fetching PDF: $e');
      if (mounted) {
        setState(() {
          _loading = false;
          _errorMessage = 'Failed to load PDF';
        });
      }
    }
  }

  Future<void> _downloadPdf() async {
    setState(() {
      _isDownloading = true;
    });

    try {
      if (await requestPermission()) {
        final directory = Directory('/storage/emulated/0/Download');
        if (!(await directory.exists())) {
          await directory.create(recursive: true);
        }

        final dio = Dio();
        final response = await dio.get(
          widget.pdfUrl,
          options: Options(responseType: ResponseType.bytes),
        );

        final fileName = widget.pdfUrl.split('/').last;
        final file = File('${directory.path}/$fileName');

        await file.writeAsBytes(response.data);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green,
              content:
                  Text(AppLocalization.of(context)!.translate('pdfSaved'))),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                  AppLocalization.of(context)!.translate('permissionStorage'))),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(AppLocalization.of(context)!.translate('errorDownload'))),
      );
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteSmoke,
      appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(
                left: !AppLocalization.of(context)!.isArabicSelected(context)
                    ? 10.w
                    : 0.w,
                right: AppLocalization.of(context)!.isArabicSelected(context)
                    ? 10.w
                    : 0.w),
            child: BackButtonWidget(onTap: () => Navigator.pop(context)),
          ),
          title: Text(
            widget.title,
            style: GoogleFonts.robotoCondensed(
                color: AppColors.riverBed, fontSize: 22.sp),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.download), // Icon for download button
              onPressed: _downloadPdf,
            ),
          ],
          centerTitle: true,
          bottom: _isDownloading
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(4.0),
                  child: LinearProgressIndicator(),
                )
              : null),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(child: Text(_errorMessage!))
                : PdfView(
                    controller: _pdfController!,
                    onDocumentLoaded: (document) {
                      debugPrint(
                          'PDF loaded with ${document.pagesCount} pages');
                    },
                    onPageChanged: (page) {},
                  ),
      ),
    );
  }
}
