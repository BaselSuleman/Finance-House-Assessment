import '../../utils/failures/field_failure/phone_number_field_failure.dart';
import '../../utils/failures/field_failure/required_field_failure.dart';
import '../regular_expression_helper.dart';

abstract class ValidationService {
  static RequiredFieldFailure? requiredFieldValidator(String value) {
    value = value.trim();
    return value.isNotEmpty == true
        ? null
        : RequiredFieldFailure(RequiredFieldError.empty);
  }

  static PhoneNumberFieldFailure? phoneNumberFieldValidator(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return PhoneNumberFieldFailure(PhoneNumberError.empty);
    }
    if (!RegularExpressionsHelper.phoneNumberReg.hasMatch(value)) {
      return PhoneNumberFieldFailure(PhoneNumberError.notValid);
    }
    return null;
  }
}
