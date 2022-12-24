import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/font.dart';
import '../../data/local/preference_manager.dart';
import '../../data/models/register.dart';
import '../../util/flow.util.dart';
import '../components/denom_counter.dart';
import '../components/green_box.dart';
import '../report/report.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Expanded _buildReportButton(Register register, BuildContext context) {
    return Expanded(
      flex: 2,
      child: GreenBox(
        onTap: () async {
          final Register? report = await Register.get(register.id);
          FlowUtil.moveTo(
            context: context,
            page: ReportPage(register: report),
          );
        },
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "View Report",
                style: poppins.copyWith(
                  fontSize: 24,
                  color: AppColors.cadetBlue,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              ...List.filled(
                3,
                const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: AppColors.cadetBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildGiveTakeRow(Register register) {
    return Expanded(
      flex: 2,
      child: GreenBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GreenBox(
                onTap: () {
                  Register.append(register, take: false);
                  PreferenceManager.clearRegisterCache();
                },
                child: Center(
                  child: Text(
                    "Give",
                    style: poppins.copyWith(
                      fontSize: 24,
                      color: AppColors.cadetBlue,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GreenBox(
                onTap: () {
                  Register.append(register, take: true);
                  PreferenceManager.clearRegisterCache();
                },
                child: Center(
                  child: Text(
                    "Take",
                    style: poppins.copyWith(
                      fontSize: 24,
                      color: AppColors.cadetBlue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildTotalCounter(Register register) {
    return Expanded(
      flex: 2,
      child: GreenBox(
        child: Center(
          child: AnimatedFlipCounter(
            value: register.total,
            prefix: "₦",
            fractionDigits: 0,
            thousandSeparator: ',',
            textStyle: nunito.copyWith(
              fontSize: 48,
              color: AppColors.cadetBlue,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildClearButton() {
    return Expanded(
      flex: 1,
      child: GreenBox(
        onTap: PreferenceManager.clearRegisterCache,
        child: Center(
          child: Text(
            "Clear",
            style: poppins.copyWith(
              fontSize: 24,
              color: AppColors.cadetBlue,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildDenomPads(Register register) {
    return Expanded(
      flex: 8,
      child: GreenBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: GreenBox(
                      onTap: () {
                        PreferenceManager.cachedRegister = register.copyWith(
                          oneThousand: register.oneThousand + 1,
                        );
                      },
                      child: Center(
                        child: DenomCounter(
                          label: "₦1000",
                          count: register.oneThousand,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GreenBox(
                      onTap: () {
                        PreferenceManager.cachedRegister = register.copyWith(
                          fiveHundred: register.fiveHundred + 1,
                        );
                      },
                      child: Center(
                        child: DenomCounter(
                          label: "₦500",
                          count: register.fiveHundred,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: GreenBox(
                      onTap: () {
                        PreferenceManager.cachedRegister = register.copyWith(
                          twoHundred: register.twoHundred + 1,
                        );
                      },
                      child: Center(
                        child: DenomCounter(
                          label: "₦200",
                          count: register.twoHundred,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GreenBox(
                      onTap: () {
                        PreferenceManager.cachedRegister = register.copyWith(
                          oneHundred: register.oneHundred + 1,
                        );
                      },
                      child: Center(
                        child: DenomCounter(
                          label: "₦100",
                          count: register.oneHundred,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: GreenBox(
                      onTap: () {
                        PreferenceManager.cachedRegister = register.copyWith(
                          fifty: register.fifty + 1,
                        );
                      },
                      child: Center(
                        child: DenomCounter(
                          label: "₦50",
                          count: register.fifty,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GreenBox(
                      onTap: () {
                        PreferenceManager.cachedRegister = register.copyWith(
                          twenty: register.twenty + 1,
                        );
                      },
                      child: Center(
                        child: DenomCounter(
                          label: "₦20",
                          count: register.twenty,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: GreenBox(
                      onTap: () {
                        PreferenceManager.cachedRegister = register.copyWith(
                          ten: register.ten + 1,
                        );
                      },
                      child: Center(
                        child: DenomCounter(
                          label: "₦10",
                          count: register.ten,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GreenBox(
                      onTap: () {
                        PreferenceManager.cachedRegister = register.copyWith(
                          five: register.five + 1,
                        );
                      },
                      child: Center(
                        child: DenomCounter(
                          label: "₦5",
                          count: register.five,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.black,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.cadetBlue,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: StreamBuilder<Register>(
              stream: PreferenceManager.cacheRegisterStream,
              builder: (context, snapshot) {
                final Register register =
                    snapshot.data ?? PreferenceManager.cachedRegister;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTotalCounter(register),
                    _buildDenomPads(register),
                    _buildClearButton(),
                    _buildGiveTakeRow(register),
                    _buildReportButton(register, context),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
