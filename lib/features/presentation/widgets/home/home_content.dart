part of 'widgets_imports.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String nameUser = "";
  String profilePicture = "";
  bool isLoading = true;

  fetchUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString("name") ?? "";
      profilePicture = preferences.getString("profilePicture") ?? "";
      isLoading = false;
    });
    print(profilePicture);
  }

  @override
  void initState() {
    fetchUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin:
            EdgeInsets.only(left: 35.w, top: 10.h, right: 35.w, bottom: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                isLoading
                    ? const CircularProgressIndicator()
                    : BlocBuilder<UploadAvatarCubit, UploadAvatarState>(
                        builder: (context, avatarState) {
                          ImageProvider backgroundImage;
                          if (avatarState is UploadAvatarLoaded) {
                            if (avatarState.uploadAvatar.isNotEmpty) {
                              backgroundImage =
                                  NetworkImage(avatarState.uploadAvatar);
                            } else {
                              backgroundImage = AssetImage(AppAssets.logo);
                            }
                          } else {
                            backgroundImage = NetworkImage(profilePicture);
                          }

                          return CircleAvatar(
                            radius: 38,
                            backgroundImage: backgroundImage,
                          );
                        },
                      ),
                SizedBox(
                  width: 15.w,
                ),
                BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                  builder: (context, state) {
                    String name;
                    if (state is UpdateProfileLoaded) {
                      if (state.updateUserProfile.user!.name!.isNotEmpty) {
                        name = state.updateUserProfile.user!.name!;
                      } else {
                        name = "";
                      }
                    } else {
                      name = nameUser;
                    }
                    return Text.rich(
                      TextSpan(
                        text: name,
                        style: GoogleFonts.roboto(
                            fontSize: 23.sp,
                            color: AppColors.carbonGrey,
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              AppLocalization.of(context)!.translate('menu'),
              style: GoogleFonts.poppins(
                  color: AppColors.pinkSwan, fontSize: 24.sp),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MenuItem(
                    title: AppLocalization.of(context)!.translate('timetable'),
                    imageAssetPath: AppAssets.timetable1,
                    onPressed: () => Navigator.pushNamed(
                        context, NavigationStrings.timetable)),
                MenuItem(
                    title:
                        AppLocalization.of(context)!.translate('myFormations'),
                    imageAssetPath: AppAssets.formation1,
                    onPressed: () => Navigator.pushNamed(
                        context, NavigationStrings.myCourses)),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MenuItem(
                    title: AppLocalization.of(context)!.translate('conference'),
                    imageAssetPath: AppAssets.courses1,
                    onPressed: () => Navigator.pushNamed(
                        context, NavigationStrings.workshop)),
                MenuItem(
                    title:
                        AppLocalization.of(context)!.translate('allFormations'),
                    imageAssetPath: AppAssets.formation,
                    onPressed: () => Navigator.pushNamed(
                        context, NavigationStrings.allCourses)),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MenuItem(
                    title: AppLocalization.of(context)!.translate('books'),
                    imageAssetPath: AppAssets.book,
                    onPressed: () =>
                        Navigator.pushNamed(context, NavigationStrings.books)),
                MenuItem(
                    title: AppLocalization.of(context)!.translate('offers'),
                    imageAssetPath: AppAssets.offers,
                    onPressed: () =>
                        Navigator.pushNamed(context, NavigationStrings.offers)),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    MenuItem(
                        title: AppLocalization.of(context)!.translate('lives'),
                        imageAssetPath: AppAssets.meeting,
                        onPressed: () => Navigator.pushNamed(
                            context, NavigationStrings.lives)),
                    Positioned(
                        right: -10.w,
                        top: -10.h,
                        child: Container(
                          child: BlocProvider(
                            create: (context) =>
                                locator<GetLivesCubit>()..getLives(),
                            child: BlocBuilder<GetLivesCubit, GetLivesState>(
                              builder: (context, state) {
                                if (state is GetLivesLoaded) {
                                  final upcomingLives =
                                      state.lives.where((live) {
                                    final startTime = live.startTime;
                                    if (startTime == null) return false;
                                    final liveDateTime =
                                        DateTime.parse(startTime);
                                    final sixHoursLater =
                                        DateTime.now().add(Duration(hours: 6));
                                    return liveDateTime.isBefore(sixHoursLater);
                                  }).toList();
                                  if (upcomingLives.isNotEmpty) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primaryColor),
                                      child: Center(
                                        child: Text(
                                          "${upcomingLives.length}",
                                          style: GoogleFonts.robotoCondensed(
                                              fontSize: 15.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    );
                                  }
                                } else if (state is GetLivesLoading) {
                                  return Container();
                                } else if (state is GetLivesFailure) {
                                  return Center(
                                    child: Text("Error:${state.message}"),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
