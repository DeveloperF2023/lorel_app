part of 'widgets_imports.dart';

class ConversationsContent extends StatelessWidget {
  final String imageUrl;
  final String groupName;
  final String senderName;
  final String lastMessage;
  final String timeLastMessage;
  final void Function()? onFetchDetailConversation;
  const ConversationsContent(
      {super.key,
      required this.imageUrl,
      required this.groupName,
      required this.senderName,
      required this.lastMessage,
      required this.timeLastMessage,
      this.onFetchDetailConversation});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFetchDetailConversation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupName,
                  style: GoogleFonts.robotoCondensed(
                      color: AppColors.secondarySmokeyGrey, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  width: HelperFunctions.screenWidth(context) > 410
                      ? HelperFunctions.screenWidth(context) * .65.w
                      : HelperFunctions.screenWidth(context) * .7.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      lastMessage == ""
                          ? const Text("")
                          : Text(
                              "$senderName: $lastMessage",
                              style: GoogleFonts.robotoCondensed(
                                  color: AppColors.gullGrey, fontSize: 14.sp),
                            ),
                      timeLastMessage == ""
                          ? const Text("")
                          : Text(
                              DateFormat.jm()
                                  .format(DateTime.parse(timeLastMessage)),
                              style: GoogleFonts.robotoCondensed(
                                  color: AppColors.gullGrey, fontSize: 14.sp),
                            )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
