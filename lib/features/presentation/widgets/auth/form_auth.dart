part of 'widgets_imports.dart';

class FormAuth extends StatefulWidget {
  bool isSignIn;
  FormAuth({super.key, required this.isSignIn});

  @override
  State<FormAuth> createState() => _FormAuthState();
}

class _FormAuthState extends State<FormAuth> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.h),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                AppLocalization.of(context)!.translate('login'),
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) =>
                      Validators.emailValidator(value, context),
                  decoration: InputDecoration(
                    hintText: AppLocalization.of(context)!.translate('email'),
                    contentPadding: EdgeInsets.only(top: 20.h),
                    hintStyle: GoogleFonts.poppins(
                        color: AppColors.nobel, fontSize: 14.sp),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Icon(
                        FontAwesomeIcons.user,
                        color: AppColors.nobel,
                        size: 12.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) =>
                      Validators.passwordValidator(value, context),
                  obscureText: isShow ? true : false,
                  decoration: InputDecoration(
                      hintText:
                          AppLocalization.of(context)!.translate('password'),
                      contentPadding: EdgeInsets.only(top: 20.h),
                      hintStyle: GoogleFonts.poppins(
                          color: AppColors.nobel, fontSize: 14.sp),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Icon(
                          FontAwesomeIcons.userLock,
                          color: AppColors.nobel,
                          size: 12.sp,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isShow = !isShow;
                            });
                          },
                          child: Icon(
                            !isShow
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: AppColors.nobel,
                            size: 14.sp,
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              PrimaryButton(
                onTap: () {
                  _signInUser();
                },
                textButton: AppLocalization.of(context)!.translate('login'),
              ),
              SizedBox(
                height: 50.h,
              ),
              MenuItem(
                title: AppLocalization.of(context)!.translate('allFormations'),
                imageAssetPath: AppAssets.formation,
                onPressed: () =>
                    Navigator.pushNamed(context, NavigationStrings.allCourses),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signInUser() {
    if (_formKey.currentState!.validate() && context.mounted) {
      setState(() {
        widget.isSignIn = true;
      });
      BlocProvider.of<CredentialCubit>(context)
          .signInUser(
        email: emailController.text,
        password: passwordController.text,
      )
          .whenComplete(() {
        Navigator.pushNamedAndRemoveUntil(
          context,
          NavigationStrings.main,
          (route) => false,
        );
      }).then((value) => _clear());
    }
    debugPrint("this is email ${emailController.text}");
    debugPrint("this is password ${passwordController.text}");
    debugPrint("isSignIn : ${widget.isSignIn}");
  }

  _clear() {
    setState(() {
      widget.isSignIn = false;
    });
  }
}
