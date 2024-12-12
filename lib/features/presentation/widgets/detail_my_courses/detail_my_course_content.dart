part of 'widgets_imports.dart';

class DetailMyCourseContent extends StatefulWidget {
  final DetailCourseEntity detailCourse;
  final void Function()? onNext;
  final void Function()? onPrevious;
  final String nextText;
  const DetailMyCourseContent({
    super.key,
    required this.detailCourse,
    required this.onNext,
    this.onPrevious,
    required this.nextText,
  });

  @override
  State<DetailMyCourseContent> createState() => _DetailMyCourseContentState();
}

class _DetailMyCourseContentState extends State<DetailMyCourseContent> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.detailCourse.video!))
          ..initialize().then((_) {
            setState(() {
              _controller.pause();
              _isPlaying = false;
            });
          });

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  void _onTap() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = _controller.value.position;
    final totalDuration = _controller.value.duration;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _onTap,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: HelperFunctions.screenHeight(context) * .25.h,
                        width: HelperFunctions.screenWidth(context),
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                      if (_showControls)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  child: Slider(
                                    value: currentPosition.inSeconds.toDouble(),
                                    max: totalDuration.inSeconds.toDouble(),
                                    activeColor: AppColors.primaryColor,
                                    onChanged: (value) {
                                      setState(() {
                                        _controller.seekTo(
                                            Duration(seconds: value.toInt()));
                                      });
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatDuration(currentPosition),
                                      style: GoogleFonts.poppins(
                                          fontSize: 14.sp, color: Colors.white),
                                    ),
                                    Text(
                                      _formatDuration(totalDuration),
                                      style: GoogleFonts.poppins(
                                          fontSize: 14.sp, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (!_showControls && !_isPlaying)
                        Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 50.sp,
                        ),
                      if (_showControls)
                        Positioned(
                          child: GestureDetector(
                            onTap: _togglePlayPause,
                            child: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 50.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.detailCourse.title!,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            _formatDuration(totalDuration),
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppLocalization.of(context)!
                            .translate("communicationDiagram"),
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "${AppLocalization.of(context)!.translate("description")} :",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.detailCourse.description!,
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "${AppLocalization.of(context)!.translate("document")} :",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Column(
                        children: widget.detailCourse.pdf!
                            .map((pdf) => Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, NavigationStrings.readPdf,
                                            arguments: {
                                              "title": pdf.name,
                                              "pdfUrl": pdf.url
                                            });
                                        setState(() {
                                          _isPlaying = false;
                                        });
                                        _controller.pause();
                                      },
                                      child: const Icon(
                                        FontAwesomeIcons.book,
                                        color: AppColors.nobel,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      pdf.name!,
                                      style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 65.h,
            color: AppColors.linkWater,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavigationMyCourses(
                    onNavigate: () {
                      setState(() {
                        _isPlaying = false;
                      });
                      _controller.pause();
                      if (widget.onPrevious != null) {
                        widget.onPrevious!();
                      }
                    },
                    isBack: true,
                  ),
                  NavigationMyCourses(
                    onNavigate: () {
                      setState(() {
                        _isPlaying = false;
                      });
                      _controller.pause();
                      if (widget.onNext != null) {
                        widget.onNext!();
                      }
                    },
                    isBack: false,
                    nextText: widget.nextText,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _downloadPdf(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }
}
