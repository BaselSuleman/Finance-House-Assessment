import 'package:easy_localization/easy_localization.dart';
import 'package:finance_house_assessment/core/utils/parse_helpers/field_failure_parser/phone_number_field_parser.dart';

import '../../failures/field_failure/field_failure.dart';
import '../../failures/field_failure/phone_number_field_failure.dart';
import '../../failures/field_failure/required_field_failure.dart';

class FieldFailureParser {
  static String mapFieldFailureToErrorMessage({required FieldFailure failure}) {
    if (failure is PhoneNumberFieldFailure) {
      return PhoneNumberFieldFailureParser.mapFieldFailureToErrorMessage(
        failure: failure,
      );
    } else if (failure is RequiredFieldFailure) {
      return ("failures.required").tr();
    } else {
      return "Invalid Info";
    }
  }
}
