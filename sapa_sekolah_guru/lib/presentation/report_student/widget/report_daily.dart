import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sapa_sekolah_guru/bloc/get_daily_reports/get_daily_reports_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/model/students_response_model.dart';
import 'package:sapa_sekolah_guru/presentation/report_daily_detail/report_daily_detail.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_failure_widget.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class ReportDaily extends StatelessWidget {
  final StudentModel student;
  const ReportDaily({
    super.key,
    required this.student,
  });

  void _navigateToReportDailyDetailPage(
    BuildContext context, {
    required String reportId,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ReportDailyDetail(
            reportId: reportId,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetDailyReportsBloc>(context).add(
          GetDailyReportsEvent(studentId: student.studentId.toString()),
        );
        return Future.value(null);
      },
      child: BlocBuilder<GetDailyReportsBloc, GetDailyReportsState>(
        builder: (context, state) {
          if (state is GetDailyReportsSuccess) {
            if (state.reports.isEmpty) {
              return const SPFailureWidget(
                message: 'Data kosong',
              );
            }
            return ListView.separated(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: state.reports.length,
              separatorBuilder: (_, __) => const SizedBox(
                height: 12,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => _navigateToReportDailyDetailPage(
                  context,
                  reportId: state.reports[index].reportDailyId.toString(),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('EEEE, d MMMM y', 'id_ID').format(
                          DateTime.parse(state.reports[index].reportDate ?? ''),
                        ),
                        style: SPTextStyles.text12W400303030,
                      ),
                      SvgPicture.asset(
                        Assets.icon.arrowRight.path,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is GetDailyReportsError) {
            return SPFailureWidget(
              message: state.message,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: SPColors.colorEAD2E0,
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    'Work Habits',
                    style: SPTextStyles.text14W400WHITE,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'Complete work in time',
                  style: SPTextStyles.text12W400303030,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.emptyCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.trueCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  color: SPColors.colorE3E3E3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'Quality of Work',
                  style: SPTextStyles.text12W400303030,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.emptyCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.trueCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: SPColors.colorC7A7D9,
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    'Needs to work on',
                    style: SPTextStyles.text14W400WHITE,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'Complete work in time',
                  style: SPTextStyles.text12W400303030,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.emptyCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.trueCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  color: SPColors.colorE3E3E3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'Quality of Work',
                  style: SPTextStyles.text12W400303030,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.emptyCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.trueCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Teacher Comments',
          style: SPTextStyles.text16W400303030,
        ),
        const SizedBox(height: 16),
        const SPTextField(
          hintText: 'Add comments',
          maxLines: 4,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SPElevatedButton(
                onPressed: () => {},
                text: 'Submit',
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
