import 'package:easy_localization/easy_localization.dart';
import 'package:finance_house_assessment/core/presentation/widgets/custom_app_bar.dart';
import 'package:finance_house_assessment/core/presentation/widgets/error_banner.dart';
import 'package:finance_house_assessment/core/presentation/widgets/loading_panel.dart';
import 'package:finance_house_assessment/core/utils/extentions.dart';
import 'package:finance_house_assessment/features/beneficiary/presentation/beneficiaries_list_cubit/beneficiaries_list_cubit.dart';
import 'package:finance_house_assessment/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../beneficiaries_list_cubit/beneficiaries_list_state.dart';
import '../widgets/beneficiary_widget.dart';

class BeneficiariesListPage extends StatefulWidget {
  const BeneficiariesListPage({super.key});

  @override
  State<BeneficiariesListPage> createState() => _BeneficiariesListPageState();
}

class _BeneficiariesListPageState extends State<BeneficiariesListPage> {
  late final BeneficiariesListCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<BeneficiariesListCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BeneficiariesListCubit, BeneficiariesListState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbar(
            title: "beneficiaries.my_beneficiaries".tr(),
            actions: [
              if (cubit.canAddBeneficiary())
                InkWell(
                  onTap: () {
                    context.push(AppPaths.beneficiary.add);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "beneficiaries.add".tr(),
                      style: context.theme.textTheme.bodyLarge,
                    ),
                  ),
                ),
            ],
          ),
          body: state.status == BeneficiariesListStatus.loading
              ? Center(child: LoadingPanel())
              : state.beneficiaryList!.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'beneficiaries.beneficiaries_empty'.tr(),
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "beneficiaries.add_beneficiary".tr(),
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    if(state.status==BeneficiariesListStatus.error)...[
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.w),
                        child: ErrorBanner(failure: state.failure!),
                      ),
                      SizedBox(height: 30.h,)
                    ],
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 20,
                        ),
                        itemBuilder: (context, index) {
                          return BeneficiaryWidget(
                            beneficiary: state.beneficiaryList![index],
                            onDelete: () {
                              cubit.deleteBeneficiary(
                                state.beneficiaryList![index],
                              );
                            },
                            onToggleActive: () {
                              cubit.toggleBeneficiaryActivation(
                                state.beneficiaryList![index],
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10.h);
                        },
                        itemCount: state.beneficiaryList!.length,
                      ),
                    ),
                  ],
                ),
        );
      },
      listener: (context, state) {
        if (state.status == BeneficiariesListStatus.deleted) {
          "beneficiaries.deleted".tr().showToast();
        } else if (state.status == BeneficiariesListStatus.updated) {
          "beneficiaries.updated".tr().showToast();
        }
      },
    );
  }
}
