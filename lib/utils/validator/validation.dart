class Validator {
  static String? validateIsEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    final mmPhoneRegExp = RegExp(r'^(09\d{7,11}|\+959\d{9,11})$');

    if (!mmPhoneRegExp.hasMatch(value)) {
      return 'Invalid Myanmar Phone Number';
    }

    return null;
  }

  static String? validateMinTemperature(String? minValue, String maxValue) {
    if (minValue == null || minValue.isEmpty) {
      return 'Min temperature is required';
    }

    final minTemp = int.tryParse(minValue);
    if (minTemp == null) {
      return 'Must be a valid number.';
    }

    if (maxValue.isNotEmpty) {
      final maxTemp = int.tryParse(maxValue);
      if (maxTemp != null && minTemp > maxTemp) {
        return 'Min temperature cannot be greater than Max temperature.';
      }
    }
    return null;
  }

  static String? validateMaxTemperature(String minValue, String? maxValue) {
    if (maxValue == null || maxValue.isEmpty) {
      return 'Max temperature is required';
    }

    final maxTemp = int.tryParse(maxValue);
    if (maxTemp == null) {
      return 'Must be a valid number.';
    }

    if (minValue.isNotEmpty) {
      final minTemp = int.tryParse(minValue);
      if (minTemp != null && minTemp > maxTemp) {
        return 'Max temperature cannot be less than Min temperature.';
      }
    }
    return null;
  }
}
