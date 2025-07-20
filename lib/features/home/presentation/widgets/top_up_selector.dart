import 'package:easy_localization/easy_localization.dart';
import 'package:finance_house_assessment/core/utils/extentions.dart';
import 'package:finance_house_assessment/features/home/data/model/top_up_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'action_button.dart';

class TopUpSelector extends StatefulWidget {
  final ValueChanged<int>? onAmountChanged;
  final List<TopUpOptionModel> topUpOptions;
  final double currentAmount;

  const TopUpSelector({super.key, this.onAmountChanged, required this.topUpOptions, required this.currentAmount});

  @override
  _TopUpSelectorState createState() => _TopUpSelectorState();
}

class _TopUpSelectorState extends State<TopUpSelector> {
  int _currentIndex = 0;

  List<TopUpOptionModel> get _topUpOptions => widget.topUpOptions;

  int get _currentAmount => _topUpOptions[_currentIndex].amount.toInt();

  @override
  void initState() {
    super.initState();

    if (widget.currentAmount != 0) {
      final index = _topUpOptions.indexWhere((element) => element.amount == widget.currentAmount);
      if (index != -1) {
        _currentIndex = index;
      }
    }

    if (widget.onAmountChanged != null) {
      widget.onAmountChanged!(_currentAmount);
    }
  }

  void _incrementAmount() {
    setState(() {
      if (_currentIndex < _topUpOptions.length - 1) {
        _currentIndex++;
      } else {}
      if (widget.onAmountChanged != null) {
        widget.onAmountChanged!(_currentAmount);
      }
    });
  }

  void _decrementAmount() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      } else {}
      if (widget.onAmountChanged != null) {
        widget.onAmountChanged!(_currentAmount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = Theme.of(context).colorScheme.outline;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ActionButton(
            icon: Icons.add,
            backgroundColor: context.theme.primaryColor,
            iconColor: Colors.white,

            onPressed: _incrementAmount,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              height: 55.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: borderColor, width: 1.5),
              ),
              child: Center(
                child: Text(
                  "$_currentAmount ${'beneficiaries.aed'.tr()}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          ActionButton(
            icon: Icons.remove,

            backgroundColor: context.theme.primaryColor,
            onPressed: _decrementAmount,
          ),
        ],
      ),
    );
  }
}
