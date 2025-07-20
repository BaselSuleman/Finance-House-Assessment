import 'package:finance_house_assessment/features/beneficiary/presentation/pages/add_beneficiary.dart';
import 'package:finance_house_assessment/features/home/presentation/pages/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'core/data/enums/auth_state.dart';
import 'features/beneficiary/presentation/pages/beneficiaries_list.dart';

abstract class AppPaths {
  static const main = _MainPaths();
  static const beneficiary = _BeneficiariesPaths();
}

class _MainPaths {
  const _MainPaths();

  String get home => '/home';
}

class _BeneficiariesPaths {
  const _BeneficiariesPaths();

  String get list => '/beneficiary/list';

  String get add => '/beneficiary/add';
}

GoRouter getRouter(AuthState authState) {
  String initialPath = '/';
  switch (authState) {
    case AuthState.authenticated:
      initialPath = AppPaths.main.home;
      break;
  }
  return GoRouter(
    initialLocation: initialPath,
    routes: <GoRoute>[
      GoRoute(
        path: AppPaths.beneficiary.list,
        builder: (BuildContext context, GoRouterState state) =>
            const BeneficiariesListPage(),
      ),
      GoRoute(
        path: AppPaths.beneficiary.add,
        builder: (BuildContext context, GoRouterState state) =>
            const AddBeneficiaryPage(),
      ),
      GoRoute(
        path: AppPaths.main.home,
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
      ),
    ],
  );
}
