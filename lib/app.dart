import 'package:easy_localization/easy_localization.dart';
import 'package:finance_house_assessment/core/presentation/blocs/theme_bloc/theme_state.dart';
import 'package:finance_house_assessment/features/beneficiary/presentation/beneficiaries_list_cubit/beneficiaries_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'core/data/enums/auth_state.dart';
import 'core/presentation/blocs/authentication/authentication_cubit.dart';
import 'core/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'core/presentation/resources/theme/app_color_scheme.dart';
import 'core/presentation/resources/theme/app_theme.dart';
import 'di/injection.dart';
import 'router.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  GoRouter router = getRouter(AuthState.authenticated);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => getIt<AuthenticationCubit>(),
        ),
        BlocProvider(create: (BuildContext context) => getIt<ThemeBloc>()),
        BlocProvider<BeneficiariesListCubit>(
          create: (context) => BeneficiariesListCubit(),
        ),
      ],
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          String message = '';
          switch (state.authState) {
            case AuthState.authenticated:
              message = 'welcome'.tr();
              break;
          }
          if (message.isNotEmpty) {
            Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
          router = getRouter(state.authState);
        },
        builder: (context, state) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              ThemeMode themeMode = ThemeMode.light;

              if (state is DarkThemeState) {
                themeMode = ThemeMode.dark;
              } else if (state is LightThemeState) {
                themeMode = ThemeMode.light;
              } else if (state is ThemeInitial) {
                themeMode = state.isDarkMode ? ThemeMode.dark : ThemeMode.light;
              }
              return ScreenUtilInit(
                designSize: const Size(428, 926),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) {
                  return MaterialApp.router(
                    routeInformationProvider: router.routeInformationProvider,
                    routeInformationParser: router.routeInformationParser,
                    routerDelegate: router.routerDelegate,
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    title: 'Assessment',
                    theme: AppTheme(AppLightColorScheme()).getThemeData(context),
                    darkTheme: AppTheme(AppDarkColorScheme()).getThemeData(context),
                    themeMode: themeMode,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
