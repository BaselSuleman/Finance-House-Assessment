
import 'package:easy_localization/easy_localization.dart';
import 'package:finance_house_assessment/core/utils/parse_helpers/failure_parser.dart';
import 'package:finance_house_assessment/core/utils/parse_helpers/field_failure_parser/field_failure_parser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../di/injection.dart';
import '../presentation/blocs/theme_bloc/theme_bloc.dart';
import 'failures/base_failure.dart';
import 'failures/field_failure/field_failure.dart';

extension ContextMethods on BuildContext {
  String failureParser(Failure failure) =>
      FailureParser.mapFailureToString(failure: failure, context: this);

  String? fieldFailureParser(FieldFailure? failure) => failure == null
      ? null
      : FieldFailureParser.mapFieldFailureToErrorMessage(
    failure: failure,
  );

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDark => getIt<ThemeBloc>().isDark;


  bool get isArabic => locale.languageCode == 'ar';



}
extension ShowToast on String {
  void showToast({ToastGravity toastGravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
      msg: this,
      toastLength: Toast.LENGTH_SHORT,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}