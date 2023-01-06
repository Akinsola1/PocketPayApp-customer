
/// Class of validation functions that the app will use
///   - This class should be used as a mixin using the `with` keyword
class Validators {
  final phoneNumberRegExp = RegExp(
      r'^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$');
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final zipCodeRegExp = RegExp(r'^[0-9]{5}(?:-[0-9]{4})?$');

  String password = "";

  String? validateEmail(String value) {
    if (!emailRegExp.hasMatch(value.trim())) {
      return 'invalid email';
    }
    if (value.isEmpty) {
      return 'email field cannot be empty';
    }
    return null;
  }


  String? validateAmount(String value) {
    if (value.length < 4) {
      return 'Amount too small';
    }
    if (value.length > 10) {
      return 'Amount too large';
    }
    return null;
  }

  String? validateName(String value) {
    if (value.length < 3) {
      return 'entry is too short';
    }
    if (value.isEmpty) {
      return 'name field cannot be empty';
    }
    return null;
  }

  String? validatePhoneNumber(String value) {
    if (!phoneNumberRegExp.hasMatch(value.trim())) {
      return 'invalid phonenumber';
    }
    return null;
  }

  String? validateComment(String value) {
    if (value.isEmpty) return "Field cannot be empty";
    if (value.length < 3) return "Invalid input";


    return null;
  }

  String? validateAccountNumber(String value) {
    if (value.length < 9) return "Incomplete Account Number";
    return null;
  }
  String? validateNIN(String value) {
    if (value.length < 11) return "Invalid NIN";
    if (value.isEmpty) return "Field cannot be empty";

    return null;
  }

  String? validateZip(String value) {
    if (!zipCodeRegExp.hasMatch(value.trim())) {
      return 'invalid zip code';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.trim().isEmpty) {
      return 'password field cannot be empty';
    } else if (value.length < 8) {
      return 'password is too short';
    }
    password = value;
    return null;
  }

  String? confirmPassword(String confirmPassword) {
    if (confirmPassword != password) {
      return 'passwords do not match';
    } else if (confirmPassword.isEmpty) {
      return 'confirm password field cannot be empty';
    }
    return null;
  }

  String? validatePin(String value) {
    if (value.trim().isEmpty) {
      return 'password field cannot be empty';
    } else if (value.length != 6) {
      return 'pin must be 6 numbers';
    }
    return null;
  }


  String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$d$m$y";
  }

  // String? valdateDate(String value) {
  //   bool isdate = isValidDate(value);
  //   DateTime date;
  //   DateTime now = DateTime.now();
  //   DateTime beg = DateFormat("dd/MM/yyyy").parse('01/01/1800');
  //   DateTime end = DateFormat("dd/MM/yyyy").parse('01/01/3000');

  //   try {
  //     date = DateFormat("dd/MM/yyyy").parse(value);
  //     //isdate = true;
  //   } catch (e) {
  //     isdate = false;
  //     print('Note a correct date');
  //   }

  //   if (value.trim().isEmpty) {
  //     return 'Date cannot be empty';
  //   } else if (!isdate) {
  //     return 'Enter a correct date';
  //   } else if (date.isAfter(beg) && date.isBefore(end)) {
  //     return null;
  //   } else {
  //     return 'Date out of range';
  //   }

  // }

  String? validateCard(String input) {
    if (input.isEmpty) {
      return "Please enter a credit card number";
    }

    // input = getCleanedNumber(input);

    if (input.length < 8) {
      // No need to even proceed with the validation if it's less than 8 characters
      return "Not a valid credit card number";
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }

    return "You entered an invalid credit card number";
  }
}
