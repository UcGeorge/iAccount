import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class GreenBox extends Container {
  GreenBox({
    super.key,
    super.margin,
    super.padding,
    super.child,
    double? borderWidth,
    Color? color,
    this.onTap,
  }) : super(
          decoration: BoxDecoration(
            color: color ?? AppColors.transparent,
            border: Border.all(
              color: AppColors.cadetBlue,
              width: borderWidth ?? 1,
            ),
          ),
        );

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: super.build(context),
    );
  }
}
