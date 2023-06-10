class Validator {
  static String? textFieldValidator({
    String? value,
    required bool isUser,
    required bool isPhone,
    required bool isLoginPhone,
    required bool isPassword,
    required bool isConfPass,
    required bool isLoginPass,
    required String passController,
  }) {
    if (isUser) {
      if (value == null || value.isEmpty) {
        return "Username is required";
      }
    }
    if (isPhone) {
      if (value == null || value.isEmpty) {
        return "Mobile number is required";
      } else if (value.length != 10) {
        return "Enter valid mobile number";
      }
    }
    if (isLoginPhone) {
      if (value == null || value.isEmpty) {
        return "Enter the mobile number";
      } else if (value.length != 10) {
        return "Enter valid mobile number";
      }
    }
    if (isPassword) {
      RegExp isUppercase = RegExp(r'^(?=.*?[A-Z])');
      RegExp islowercase = RegExp(r'^(?=.*?[a-z])');
      RegExp isOnenumber = RegExp(r'^(?=.*?[0-9])');
      RegExp isSpecial = RegExp(r'^(?=.*?[!@#\$&*~])');
      RegExp islength8 = RegExp(r'^.{8,}');
      if (value == null || value.isEmpty) {
        return "Password is required";
      } else if (!islength8.hasMatch(value)) {
        return "Password must be 8 or more characters";
      } else if (!isUppercase.hasMatch(value)) {
        return "Password must contain atleast one\nUppercase";
      } else if (!islowercase.hasMatch(value)) {
        return "Password must contain atleast one\nlowercase";
      } else if (!isOnenumber.hasMatch(value)) {
        return "Password must contain atleast\none number";
      } else if (!isSpecial.hasMatch(value)) {
        return "Should contain atleast one\nspecial character eg.(!@#\$&*~)";
      }
    }

    if (isConfPass) {
      if (value == null || value.isEmpty) {
        return "Enter the Confirm password";
      } else if (value != passController) {
        return "Password must match";
      }
    }
    if (isLoginPass) {
      if (value == null || value.isEmpty) {
        return "Enter the password";
      } else {
        return null;
      }
    }
    return null;
  }
}
