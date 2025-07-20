import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:finance_house_assessment/core/presentation/resources/theme/app_material_color.dart';
import 'package:finance_house_assessment/core/presentation/widgets/loading_banner.dart';
import 'package:finance_house_assessment/core/presentation/widgets/loading_panel.dart';
import 'package:finance_house_assessment/core/utils/extentions.dart';
import 'package:finance_house_assessment/core/utils/failures/failures.dart';
import 'package:finance_house_assessment/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:finance_house_assessment/features/home/presentation/home_cubit/home_state.dart';
import 'package:finance_house_assessment/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/widgets/error_banner.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';
import '../../../beneficiary/presentation/beneficiaries_list_cubit/beneficiaries_list_cubit.dart';
import '../widgets/select_benefeiciry_bootm_sheet.dart';
import '../widgets/top_up_button.dart';
import '../widgets/top_up_selector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeCubit homeCubit;

  late final BeneficiariesListCubit beneficiariesCubit =
      BlocProvider.of<BeneficiariesListCubit>(context);

  @override
  void initState() {
    homeCubit = HomeCubit(beneficiariesCubit);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: homeCubit,
      builder: (context, state) {
        return Scaffold(
          body: state.status == HomeStatus.loading
              ? LoadingPanel()
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 20.h,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        changeLanguage(),
                        headerCard(),
                        balanceWidget(),
                        actionsButton(),
                        errorMsg(),
                        SizedBox(height: 0.10.sh),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: TopUpButton(
            text: 'home.top-up'.tr(),
            onPressed: _showBeneficiarySelectionSheet,
          ),
        );
      },
      listener: (context, state) {
        if (state.status == HomeStatus.topUpSuccess) {
          homeCubit.updateBeneficiaries();
          "home.process_successful".tr().showToast();
        }
      },
    );
  }

  Widget changeLanguage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (context.isArabic) {
                context.setLocale(const Locale('en'));
              } else {
                context.setLocale(const Locale('ar'));
              }
            },
            child: Text(
              context.isArabic ? "english".tr() : "arabic".tr(),
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              homeCubit.changeTheme(context.isDark);
            },
            icon: Icon(
              !context.isDark ? Icons.dark_mode : Icons.light_mode,
              color: Theme.of(context).iconTheme.color,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget headerCard() {
    return homeCubit.state.userModel == null
        ? LoadingBanner()
        : Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          "assets/logo/app_logo.png",
                          height: 100.h,
                          width: 100.w,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "${'home.hello'.tr()} ${homeCubit.state.userModel?.name}",
                            style: context.theme.textTheme.bodyLarge?.copyWith(
                              color: AppMaterialColors.grey.shade700,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          RichText(
                            textDirection: TextDirection.ltr,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${homeCubit.state.userModel?.phone} ",
                                  style: context.theme.textTheme.bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                      ),
                                ),
                                TextSpan(
                                  text: "home.prepaid".tr(),
                                  style: context.theme.textTheme.bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          InkWell(
                            onTap: () async {
                              await context.push(AppPaths.beneficiary.list);
                              homeCubit.getInfo();
                            },
                            child: Row(
                              children: [
                                Text(
                                  "home.beneficiaries".tr(),
                                  style: context.theme.textTheme.bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        color: context.theme.primaryColor,
                                      ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: context.theme.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  Widget balanceWidget() {
    return Container(
      width: 1.sw,
      height: 140.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [
            context.theme.primaryColor,
            context.theme.primaryColor.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'home.your_balance'.tr(),
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              ),
              Text(
                '${beneficiariesCubit.state.userModel?.balance} ${'beneficiaries.aed'.tr()}'
                    .tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(),
            ],
          ),
          CustomSvgIcon(
            Assets.icons.balanceIcon,
            color: context.theme.primaryColor,
            size: 60.w,
          ),
        ],
      ),
    );
  }

  Widget actionsButton() {
    return TopUpSelector(
      currentAmount: homeCubit.state.selectedAmount,
      onAmountChanged: (newAmount) {
        homeCubit.updateSelectedAmount(newAmount.toDouble());
      },
      topUpOptions: homeCubit.state.topUpOptionList ?? [],
    );
  }

  void _showBeneficiarySelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return BeneficiarySelectionSheet(
          beneficiaries: homeCubit.state.beneficiaryList ?? [],
          selectedBeneficiary: homeCubit.state.selectedBeneficiary,
          onSelect: (beneficiary) async {
            await homeCubit.performTopUp(
              beneficiary: beneficiary,
              amount: homeCubit.state.selectedAmount,
            );
          },
          onNavigate: () async {
            context.pop();
            await context.push(AppPaths.beneficiary.list);
            homeCubit.getInfo();
          },
        );
      },
    );
  }

  Widget errorMsg() {
    return homeCubit.state.status == HomeStatus.error
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ErrorBanner(
              failure:
                  homeCubit.state.failure ??
                  CustomFailure(message: "failures.some_thing_wrong".tr()),
            ),
          )
        : SizedBox();
  }
}
