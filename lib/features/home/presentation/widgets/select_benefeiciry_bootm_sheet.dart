import 'package:finance_house_assessment/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../beneficiary/data/model/beneficiaryModel.dart';

class BeneficiarySelectionSheet extends StatelessWidget {
  final List<BeneficiaryModel> beneficiaries;
  final BeneficiaryModel? selectedBeneficiary;
  final void Function(BeneficiaryModel) onSelect;
  final VoidCallback onNavigate;

  const BeneficiarySelectionSheet({
    super.key,
    required this.beneficiaries,
    required this.selectedBeneficiary,
    required this.onSelect,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 0.6.sh),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'home.select_beneficiary'.tr(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold,fontSize: 20.sp),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child:beneficiaries.isEmpty?Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 80.sp,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'beneficiaries.beneficiaries_empty'.tr(),
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "beneficiaries.add_beneficiary".tr(),
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ): ListView.separated(
              shrinkWrap: true,
              itemCount: beneficiaries.length,
              itemBuilder: (context, index) {
                final beneficiary = beneficiaries[index];
                final isSelected = selectedBeneficiary?.id == beneficiary.id;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: beneficiary.active
                        ? Theme.of(context).primaryColor.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.2),
                    child: Text(
                      beneficiary.nickname.isNotEmpty ? beneficiary.nickname[0].toUpperCase() : '?',
                      style: context.theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                  title: Text(
                    beneficiary.nickname,
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  subtitle: Text(
                    beneficiary.phoneNumber,
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor)
                      : (!beneficiary.active
                      ? Icon(Icons.do_not_disturb_on_outlined,
                      color: Colors.grey[400], size: 20.sp)
                      : null),
                  onTap: beneficiary.active
                      ? () {
                    Navigator.of(context).pop();
                    onSelect(beneficiary);
                  }
                      : null,
                  selected: isSelected,
                  selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.05),
                  enabled: beneficiary.active,
                );
              },
              separatorBuilder: (_, __) => Divider(indent: 70.w, height: 1),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: TextButton.icon(
              icon: const Icon(Icons.add_circle_outline),
              label: Text("home.manage".tr()),
              onPressed: onNavigate
            ),
          )
        ],
      ),
    );
  }
}
