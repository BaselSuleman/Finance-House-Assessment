import 'package:easy_localization/easy_localization.dart';
import 'package:finance_house_assessment/features/beneficiary/data/model/beneficiaryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BeneficiaryWidget extends StatelessWidget {
  final BeneficiaryModel beneficiary;
  final VoidCallback? onDelete;

  const BeneficiaryWidget({
    super.key,
    required this.beneficiary,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isActive = beneficiary.active;

    return Opacity(
      opacity: isActive ? 1.0 : 0.7,
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: theme.primaryColor.withAlpha(
                      (0.5 * 255).round(),
                    ),
                    child: Text(
                      beneficiary.nickname.isNotEmpty
                          ? beneficiary.nickname[0].toUpperCase()
                          : '',
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                beneficiary.nickname,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              width: 10.sp,
                              height: 10.sp,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? Colors.greenAccent.shade700
                                    : Colors.grey.shade400,
                                shape: BoxShape.circle,
                              ),

                              child: Tooltip(
                                message: isActive ? 'Active' : 'Inactive',
                                child: Container(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          beneficiary.phoneNumber,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[700],
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isActive || onDelete != null)
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                      onSelected: (value) {
                        if (value == 'delete') {
                          _showDeleteConfirmationDialog(
                            context,
                            beneficiary,
                            onDelete,
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                            if (onDelete != null)
                              PopupMenuItem<String>(
                                value: 'delete',
                                child: ListTile(
                                  leading: Icon(
                                    Icons.delete_outline,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text(
                                    'beneficiaries.delete'.tr(),
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                ),
                              ),
                          ],
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.more_vert, color: Colors.grey[300]),
                    ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'beneficiaries.spent_month'.tr(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '${'beneficiaries.aed'.tr()} ${beneficiary.topUpAmountThisMonth.toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.send_to_mobile_outlined, size: 18.sp),
                    label: Text('beneficiaries.top_up'.tr()),
                    style: ElevatedButton.styleFrom(
                      maximumSize:  Size(double.infinity, 48.h),
                      backgroundColor: isActive
                          ? theme.primaryColor
                          : Colors.grey.shade400,
                      foregroundColor: isActive
                          ? theme.colorScheme.onPrimary
                          : Colors.grey.shade700,
                    ),
                    onPressed: isActive ? () {
                      context.pop();
                    } : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    BeneficiaryModel beneficiary,
    VoidCallback? onDelete,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('beneficiaries.confirm_delete'.tr()),
          content: Text(
            '${'beneficiaries.are_sure_delete'.tr()} ${beneficiary.nickname} ?',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'.tr()),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              child: Text('delete'.tr(), style: TextStyle(color: Colors.red)),
              onPressed: () {
                onDelete?.call();
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
