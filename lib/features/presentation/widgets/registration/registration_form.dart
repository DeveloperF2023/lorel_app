part of 'widgets_imports.dart';

class RegistrationForm extends StatefulWidget {
  final String selectedDiploma;
  final String formationId;

  const RegistrationForm(
      {super.key, required this.selectedDiploma, required this.formationId});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isShowUserPassword = false;
  bool isShowPassword = false;
  bool isShowConfirmPassword = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.h, bottom: 20.h),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                AppLocalization.of(context)!.translate("registerFormation"),
                style: GoogleFonts.poppins(
                  fontSize: 24.sp,
                ),
              ),
              TextFieldApp(
                icon: FontAwesomeIcons.user,
                hintText: AppLocalization.of(context)!.translate("name"),
                controller: nameController,
                validator: (value) => Validators.nameValidator(value, context),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFieldApp(
                icon: FontAwesomeIcons.user,
                hintText: AppLocalization.of(context)!.translate("email"),
                controller: emailController,
                validator: (value) => Validators.emailValidator(value, context),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFieldApp(
                icon: FontAwesomeIcons.user,
                hintText: AppLocalization.of(context)!.translate("password"),
                controller: passwordController,
                validator: (value) =>
                    Validators.passwordValidatorRegister(value, context),
                obscureText: isShowPassword ? true : false,
                onTap: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
                suffixIcon: !isShowPassword
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
                hasSuffixIcon: true,
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFieldApp(
                icon: FontAwesomeIcons.user,
                hintText:
                    AppLocalization.of(context)!.translate("confirmPassword"),
                controller: confirmPasswordController,
                validator: (value) => Validators.confirmPassword(
                    value, passwordController.text, context),
                obscureText: isShowConfirmPassword ? true : false,
                onTap: () {
                  setState(() {
                    isShowConfirmPassword = !isShowConfirmPassword;
                  });
                },
                suffixIcon: !isShowConfirmPassword
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
                hasSuffixIcon: true,
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFieldApp(
                icon: FontAwesomeIcons.mobileScreen,
                hintText: AppLocalization.of(context)!.translate("phone"),
                controller: phoneController,
                validator: (value) => Validators.phoneValidator(value, context),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFieldApp(
                icon: FontAwesomeIcons.locationDot,
                hintText: AppLocalization.of(context)!.translate("country"),
                controller: countryController,
                validator: (value) =>
                    Validators.countryValidator(value, context),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFieldApp(
                icon: FontAwesomeIcons.locationDot,
                hintText: AppLocalization.of(context)!.translate("address"),
                controller: addressController,
                validator: (value) =>
                    Validators.addressValidator(value, context),
              ),
              SizedBox(
                height: 25.h,
              ),
              BlocConsumer<RegisterUserCubit, RegisterUserState>(
                listener: (context, state) {
                  if (state is RegisterUserLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("The user registered successfully")),
                    );
                    Navigator.pushNamed(
                      context,
                      NavigationStrings.payment,
                      arguments: {
                        "selectedDiplomas": widget.selectedDiploma,
                        "formationId": widget.formationId,
                      },
                    );
                  } else if (state is RegisterUserFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalization.of(context)!
                              .translate('emailExist'))),
                    );
                    debugPrint("Error: ${state.message}");
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    textButton:
                        AppLocalization.of(context)!.translate("register"),
                    onTap: isLoading
                        ? null
                        : () {
                            _signUpUser();
                          },
                  );
                },
              ),
              if (isLoading)
                const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryColor)),
            ],
          ),
        ),
      ),
    );
  }

  void _signUpUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final requests = RequestRegisterUserModel(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        passwordConfirmation: confirmPasswordController.text,
        password: passwordController.text,
        country: countryController.text,
        address: addressController.text,
      );
      await BlocProvider.of<RegisterUserCubit>(context)
          .signUpUser(requests: requests);
      setState(() {
        isLoading = false;
      });

      debugPrint("This is email ${emailController.text}");
      debugPrint("This is password ${passwordController.text}");
    }
  }
}
