import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RideDetailsField extends StatelessWidget {
  final String? label;
  final String value;
  final bool borderLeft;
  final bool borderTop;
  final bool borderRight;
  final bool borderBot;
  final double _borderWith = 1.5;

  const RideDetailsField(
      {Key? key,
      this.label,
      required this.value,
      this.borderLeft = false,
      this.borderTop = true,
      this.borderRight = false,
      this.borderBot = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 256.h,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(32.h, 32.h, 16.h, 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
              width: _borderWith,
              color: borderLeft
                  ? Theme.of(context).primaryColor
                  : Colors.transparent),
          top: BorderSide(
              width: _borderWith,
              color: borderTop
                  ? Theme.of(context).primaryColor
                  : Colors.transparent),
          right: BorderSide(
              width: _borderWith,
              color: borderRight
                  ? Theme.of(context).primaryColor
                  : Colors.transparent),
          bottom: BorderSide(
              width: _borderWith,
              color: borderBot
                  ? Theme.of(context).primaryColor
                  : Colors.transparent),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 56.sp),
          ),
          const Spacer(),
          FittedBox(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 72.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
