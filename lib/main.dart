import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/utils/app_bloc_observer.dart';
import 'di/injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = AppBlocObserver();


  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: App()),
  );
}

