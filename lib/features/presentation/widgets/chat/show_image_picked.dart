part of 'widgets_imports.dart';

class ShowImagePicked extends StatelessWidget {
  final void Function() onSend;
  final File file;
  final bool? isSendFetched;
  const ShowImagePicked(
      {super.key,
      required this.onSend,
      required this.file,
      this.isSendFetched = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context)!.translate("selectedImage")),
        actions: [
          isSendFetched == true
              ? IconButton(
                  icon: Icon(
                    Icons.send,
                    color: AppColors.primaryColor,
                    size: 20.sp,
                  ),
                  onPressed: onSend,
                )
              : Container()
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: HelperFunctions.screenHeight(context) * .77.h,
            width: HelperFunctions.screenWidth(context).w,
            child: Image.file(
              file,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
