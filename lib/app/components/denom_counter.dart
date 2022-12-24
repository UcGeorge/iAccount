import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/font.dart';

class DenomCounter extends StatelessWidget {
  const DenomCounter({
    Key? key,
    required this.label,
    required this.count,
  }) : super(key: key);

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: nunito.copyWith(
          fontSize: 20,
          color: AppColors.cadetBlue,
        ),
        children: [
          if (count != 0)
            TextSpan(
              text: " - $count",
              style: poppins.copyWith(
                fontSize: 20,
                color: AppColors.tomato,
              ),
            ),
        ],
      ),
    );
  }
}
