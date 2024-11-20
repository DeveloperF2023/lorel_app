import 'package:flutter/cupertino.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';

class Validators {
  static bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    // At least one uppercase, one lowercase, one number, one special character, and 8-20 characters long
    String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,20}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  static String? emailValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context)!.translate("emptyEmail");
    } else if (!isValidEmail(value)) {
      return AppLocalization.of(context)!.translate("invalidEmail");
    }
    return null;
  }

  static String? passwordValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context)!.translate("emptyPassword");
    }
    return null;
  }

  static String? passwordValidatorRegister(
      String? value, BuildContext context) {
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return AppLocalization.of(context)!.translate("emptyPassword");
    } else if (value.length < 8) {
      return AppLocalization.of(context)!.translate("passwordTooShort");
    } else if (!regex.hasMatch(value)) {
      return AppLocalization.of(context)!.translate("invalidPassword");
    }
    return null;
  }

  static String? usernameValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context)!.translate("emptyUsername");
    }
    return null;
  }

  static String? nameValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context)!.translate("emptyName");
    }
    return null;
  }

  static String? firstNameValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context)!.translate("emptyFirstName");
    }
    return null;
  }

  static String? lastNameValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context)!.translate("emptyLastName");
    }
    return null;
  }

  static String? phoneValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context)!.translate("emptyPhone");
    } else if (value.length < 10) {
      return AppLocalization.of(context)!.translate("phoneLessThanTen");
    } else if (value.length > 10) {
      return AppLocalization.of(context)!.translate("phoneLessThanTen");
    }
    return null;
  }

  static String? confirmPassword(
      String? value, String password, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context)!
          .translate("emptyConfirmationPassword");
    } else if (value != password) {
      return AppLocalization.of(context)!.translate("passwordNotMatch");
    }
    return null;
  }

  static String? countryValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context)!.translate("emptyCountry");
    }
    return null;
  }

  static String? addressValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context)!.translate("emptyAddress");
    }
    return null;
  }

  static String? birthdayValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context)!.translate("emptyBirthday");
    }
    return null;
  }

  static String? cinValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context)!.translate("emptyID");
    }
    return null;
  }
}
