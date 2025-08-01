import 'package:finance_house_assessment/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';


final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection() async {
  await getIt.init();
}

Future<void> resetInjection() async {
  await getIt.reset();
}
