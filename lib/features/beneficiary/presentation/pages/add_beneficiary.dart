import 'package:easy_localization/easy_localization.dart';
import 'package:finance_house_assessment/core/presentation/widgets/custom_app_bar.dart';
import 'package:finance_house_assessment/core/presentation/widgets/loading_banner.dart';
import 'package:finance_house_assessment/core/utils/extentions.dart';
import 'package:finance_house_assessment/features/beneficiary/presentation/add_beneficiaries_cubit/add_beneficiary_state.dart';
import 'package:finance_house_assessment/features/beneficiary/presentation/beneficiaries_list_cubit/beneficiaries_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/services/validation_service.dart';
import '../../../../core/presentation/widgets/custom_form_field.dart';
import '../add_beneficiaries_cubit/add_beneficiary_cubit.dart';

class AddBeneficiaryPage extends StatefulWidget {
  const AddBeneficiaryPage({super.key});

  @override
  State<AddBeneficiaryPage> createState() => _AddBeneficiaryPageState();
}

class _AddBeneficiaryPageState extends State<AddBeneficiaryPage> {
  final _nicknameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _nicknameFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  late final AddBeneficiaryCubit cubit;

  @override
  void initState() {
    cubit = AddBeneficiaryCubit(
      BlocProvider.of<BeneficiariesListCubit>(context),
    );
    super.initState();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _phoneNumberController.dispose();
    _nicknameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddBeneficiaryCubit, AddBeneficiaryState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbar(title: "beneficiaries.new_beneficiary".tr()),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CustomFormField(
                    controller: _nicknameController,
                    focusNode: _nicknameFocusNode,
                    title: "beneficiaries.nickname".tr(),
                    hintText: "beneficiaries.nickname".tr(),
                    textStyle: context.textTheme.displaySmall!.copyWith(
                      fontSize: 16.sp,
                    ),
                    validator: ValidationService.requiredFieldValidator,
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 10.w),
                      child: Icon(Icons.person_outline),
                    ),
                    prefixIconConstraints: BoxConstraints(maxWidth: 50.w),
                    autoValidate: state.validateField,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: HexColor.fromHex("#E1E1E1"),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: HexColor.fromHex("#2EB9CC"),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    isRequired: true,
                    maxLength: 20,
                  ),
                  SizedBox(height: 30.h),
                  CustomFormField(
                    controller: _phoneNumberController,
                    focusNode: _phoneNumberFocusNode,
                    title: "beneficiaries.uae_number".tr(),
                    hintText: "05XXXXXXXX",
                    textStyle: context.textTheme.displaySmall!.copyWith(
                      fontSize: 16.sp,
                    ),
                    validator: ValidationService.phoneNumberFieldValidator,
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 10.w),
                      child: Icon(Icons.phone_outlined),
                    ),
                    prefixIconConstraints: BoxConstraints(maxWidth: 50.w),
                    autoValidate: state.validateField,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: HexColor.fromHex("#E1E1E1"),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: HexColor.fromHex("#2EB9CC"),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    isRequired: true,
                  ),

                  SizedBox(height: 30.h),

                  state.status == AddBeneficiaryStatus.loading
                      ? LoadingBanner()
                      : ElevatedButton.icon(
                          icon: Icon(Icons.save_outlined),
                          label: Text('beneficiaries.save_beneficiary'.tr()),
                          onPressed: () async {
                            await cubit.addBeneficiary(
                              name: _nicknameController.text.trim(),
                              phoneNumber: _phoneNumberController.text.trim(),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.status == AddBeneficiaryStatus.addedSuccess) {
          FocusScope.of(context).unfocus();
          "beneficiaries.added_successfully".tr().showToast();
          context.pop();
        }
      },
    );
  }
}
