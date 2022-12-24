import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';
import '../../constants/font.dart';
import '../../data/models/register.dart';
import '../../util/flow.util.dart';
import '../report/report.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
        title: Text(
          "History",
          style: poppins.copyWith(
            fontSize: 20,
            color: AppColors.cadetBlue,
          ),
        ),
        actions: [
          Center(
            child: InkWell(
              onTap: () =>
                  Register.deleteAll().then((value) => setState(() {})),
              child: Container(
                color: AppColors.transparent,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Clear history",
                  style: poppins.copyWith(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Register>>(
        future: Register.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(color: AppColors.cadetBlue);
          }
          if (snapshot.hasData) {
            final List<Register> reports = snapshot.data!;
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => ListTile(
                onTap: () => FlowUtil.moveTo(
                  context: context,
                  page: ReportPage(register: reports[index]),
                ),
                trailing: InkWell(
                  onTap: () => Register.delete(reports[index])
                      .then((value) => setState(() {})),
                  child: Container(
                    color: AppColors.transparent,
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                    ),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: reports[index].id,
                    style: nunito.copyWith(
                      fontSize: 16,
                      color: AppColors.cadetBlue,
                    ),
                    children: [
                      TextSpan(
                        text: " - ${NumberFormat.currency(
                          name: "₦",
                          decimalDigits: 0,
                        ).format(reports[index].total)}",
                        style: nunito.copyWith(
                          fontSize: 16,
                          color: AppColors.tomato,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(
                color: AppColors.cadetBlue,
              ),
              itemCount: reports.length,
            );
          } else {
            return Center(
              child: Text(
                "No history to show\nTry again later",
                textAlign: TextAlign.center,
                style: nunito.copyWith(
                  fontSize: 20,
                  color: AppColors.cadetBlue,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
