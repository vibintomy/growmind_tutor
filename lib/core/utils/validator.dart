String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'please enter the name';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter the mail';
  }
  if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'please enter the password';
  }

  if (value.length <= 3 || value.length >= 15) {
    return 'please enter a valid password';
  }
  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return ' enter the phone number';
  }
  return null;
}

String? validateRePassword(String? value, String? originalPassword) {
  if (value == null || value.isEmpty) {
    return 'please enter the password';
  }

  if (value.length <= 3 || value.length >= 15) {
    return 'please enter a valid password';
  }
  if (value != originalPassword) {
    return 'Password is incorrect';
  }
  return null;
}
