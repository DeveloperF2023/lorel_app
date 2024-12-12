part of 'widgets_imports.dart';

class DetailMessageContent extends StatefulWidget {
  final String userImage;
  final String body;
  final String file;
  final String type;
  final String sender;
  final String createdAt;
  final bool isCurrentUser;
  final bool isUserImage;

  const DetailMessageContent({
    super.key,
    required this.userImage,
    required this.body,
    required this.file,
    required this.type,
    required this.sender,
    required this.createdAt,
    required this.isCurrentUser,
    required this.isUserImage,
  });

  @override
  State<DetailMessageContent> createState() => _DetailMessageContentState();
}

class _DetailMessageContentState extends State<DetailMessageContent> {
  Uint8List? _cachedPdfData;
  Uint8List? _cachedImageData;
  bool isLoading = false;
  final CacheManager cacheManager = DefaultCacheManager();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Initialize data based on message type
  void _initializeData() {
    if (widget.type == "file") {
      _fetchPdfData();
    } else if (widget.type == "image") {
      _fetchImageData();
    }
  }

  // Fetch and cache PDF data
  Future<void> _fetchPdfData() async {
    if (_cachedPdfData != null) return; // Already cached

    setState(() => isLoading = true);
    try {
      final file = await cacheManager.getSingleFile(widget.file);
      final bytes = await file.readAsBytes();

      if (mounted) {
        setState(() {
          _cachedPdfData = bytes;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching PDF: $e');
      setState(() => isLoading = false);
    }
  }

  // Fetch and cache image data
  Future<void> _fetchImageData() async {
    if (_cachedImageData != null) return; // Already cached

    try {
      final file = await cacheManager.getSingleFile(widget.file);
      final bytes = await file.readAsBytes();

      if (mounted) {
        setState(() {
          _cachedImageData = bytes;
        });
      }
    } catch (e) {
      debugPrint('Error fetching image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppLocalization.of(context)!.isArabicSelected(context)
          ? EdgeInsets.only(
              top: 10.h,
              bottom: 10.h,
              right: 0.w,
              left: widget.isCurrentUser ? 10.w : 0.w)
          : EdgeInsets.only(
              top: 10.h,
              bottom: 10.h,
              right: 10.w,
              left: widget.isCurrentUser ? 0.w : 10.w),
      child: Align(
        alignment:
            widget.isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: widget.isCurrentUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: widget.isCurrentUser
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (!widget.isCurrentUser)
                  CircleAvatar(
                    radius: 15.r,
                    backgroundImage: NetworkImage(widget.userImage),
                  ),
                SizedBox(width: 8.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: widget.isCurrentUser
                        ? Colors.white
                        : AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                      bottomLeft: widget.isCurrentUser
                          ? Radius.circular(30.r)
                          : Radius.circular(0.r),
                      bottomRight: widget.isCurrentUser
                          ? Radius.circular(0.r)
                          : Radius.circular(30.r),
                    ),
                  ),
                  child: _buildContent(context),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            _buildSenderAndTimeRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (widget.type == "image") {
      return _cachedImageData != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowImageSelected(
                              cachedImageData: _cachedImageData!)));
                },
                child: Image.memory(
                  _cachedImageData!,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.6,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            )
          : _loadingPlaceholder(context);
    } else if (widget.type == "file") {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            NavigationStrings.readPdf,
            arguments: {
              "title": AppLocalization.of(context)!.translate("pdfViewer"),
              "pdfUrl": widget.file,
            },
          );
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Stack(
            children: [
              if (_cachedPdfData != null)
                PdfView(
                  controller: PdfController(
                      document: PdfDocument.openData(_cachedPdfData!)),
                ),
              if (isLoading) _loadingPlaceholderPDF(context),
            ],
          ),
        ),
      );
    } else if (widget.type == "audio") {
      return AudioWidget(audioUrl: widget.file);
    } else {
      return Text(
        widget.body,
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          color: widget.isCurrentUser ? Colors.black : Colors.white,
        ),
      );
    }
  }

  // Placeholder widget while loading data
  Widget _loadingPlaceholder(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: CustomShimmer(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.6,
      ),
    );
  }

  Widget _loadingPlaceholderPDF(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: CustomShimmer(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.6,
      ),
    );
  }

  // Widget to display sender and timestamp
  Widget _buildSenderAndTimeRow() {
    return Row(
      mainAxisAlignment: widget.isCurrentUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Text(
          widget.sender,
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            color: AppColors.greyCloud,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          widget.createdAt,
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            color: AppColors.greyCloud,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
