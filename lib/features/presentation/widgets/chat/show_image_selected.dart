part of 'widgets_imports.dart';

class ShowImageSelected extends StatefulWidget {
  final Uint8List? cachedImageData;
  const ShowImageSelected({
    super.key,
    required this.cachedImageData,
  });

  @override
  State<ShowImageSelected> createState() => _ShowImageSelectedState();
}

class _ShowImageSelectedState extends State<ShowImageSelected> {
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  Future<void> _downloadImage(Uint8List? imageData) async {
    if (imageData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image data available to download')),
      );
      return;
    }

    setState(() {
      _isDownloading = true;
    });

    try {
      if (await requestPermission()) {
        final directory = Directory('/storage/emulated/0/Download');
        if (!(await directory.exists())) {
          await directory.create(recursive: true);
        }

        final file = File(
            '${directory.path}/downloaded_image_${DateTime.now().millisecondsSinceEpoch}.png');
        await file.writeAsBytes(imageData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalization.of(context)!.translate("imageSaved"))),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  AppLocalization.of(context)!.translate("permissionStorage"))),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                AppLocalization.of(context)!.translate("errorDownloadImage"))),
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
      appBar: AppBar(
        title: Text(AppLocalization.of(context)!.translate("selectedImage")),
        actions: [
          IconButton(
            icon: const Icon(Icons.download), // Icon for download button
            onPressed: () async {
              await _downloadImage(widget.cachedImageData);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: HelperFunctions.screenHeight(context) > 840
                    ? HelperFunctions.screenHeight(context) * .74.h
                    : HelperFunctions.screenHeight(context) * .77.h,
                width: HelperFunctions.screenWidth(context).w,
                child: Image.memory(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.6,
                  widget.cachedImageData!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ],
          ),
          if (_isDownloading)
            Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
