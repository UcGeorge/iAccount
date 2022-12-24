import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';
import '../../constants/font.dart';
import '../../data/models/register.dart';
import '../../util/flow.util.dart';
import '../components/report_tile.dart';
import '../history/history.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key, required this.register});

  final Register? register;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        centerTitle: true,
        leading: InkWell(
          onTap: () => FlowUtil.back(context: context),
          child: Container(
            color: AppColors.transparent,
            child: Center(
              child: Text(
                "Back",
                style: poppins.copyWith(
                  fontSize: 16,
                  color: AppColors.cadetBlue,
                ),
              ),
            ),
          ),
        ),
        title: RichText(
          text: TextSpan(
            text: register != null ? "Report - " : "",
            style: nunito.copyWith(
              fontSize: 16,
              color: AppColors.cadetBlue,
            ),
            children: [
              if (register != null)
                TextSpan(
                  text: register!.id,
                  style: poppins.copyWith(
                    fontSize: 16,
                    color: AppColors.tomato,
                  ),
                ),
            ],
          ),
        ),
        actions: [
          Center(
            child: InkWell(
              onTap: () => FlowUtil.moveTo(
                context: context,
                page: const HistoryPage(),
              ),
              child: Container(
                color: AppColors.transparent,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "History",
                  style: poppins.copyWith(
                    fontSize: 16,
                    color: AppColors.cadetBlue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: register == null
            ? Center(
                child: Text(
                  "No report for today\nTry again later",
                  textAlign: TextAlign.center,
                  style: nunito.copyWith(
                    fontSize: 20,
                    color: AppColors.cadetBlue,
                  ),
                ),
              )
            : Column(
                children: [
                  ReportTile(
                    label: "TOTAL",
                    useNunito: true,
                    value: NumberFormat.currency(
                      name: "₦",
                      decimalDigits: 0,
                    ).format(register!.total),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        ReportTile(
                          label: "₦1000",
                          value: register!.oneThousand.toString(),
                        ),
                        ReportTile(
                          label: "₦500",
                          value: register!.fiveHundred.toString(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        ReportTile(
                          label: "₦200",
                          value: register!.twoHundred.toString(),
                        ),
                        ReportTile(
                          label: "₦100",
                          value: register!.oneHundred.toString(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        ReportTile(
                          label: "₦50",
                          value: register!.fifty.toString(),
                        ),
                        ReportTile(
                          label: "₦20",
                          value: register!.twenty.toString(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        ReportTile(
                          label: "₦10",
                          value: register!.ten.toString(),
                        ),
                        ReportTile(
                          label: "₦5",
                          value: register!.five.toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
