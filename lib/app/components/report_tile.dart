import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/font.dart';

class ReportTile extends StatelessWidget {
  const ReportTile({
    super.key,
    required this.label,
    required this.value,
    this.useNunito = false,
  });

  final String label;
  final String value;
  final bool useNunito;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: nunito.copyWith(
                fontSize: 20,
                color: AppColors.cadetBlue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: (useNunito ? nunito : poppins).copyWith(
                fontSize: 48,
                color: AppColors.tomato,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
