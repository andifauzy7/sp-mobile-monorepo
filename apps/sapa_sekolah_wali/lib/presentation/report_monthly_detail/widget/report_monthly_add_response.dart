import 'package:flutter/material.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/form/sp_text_field.dart';
import 'package:sapa_component/form/sp_validator.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/add_monthly_report_response/add_monthly_report_response_bloc.dart';

class ReportMonthlyAddResponse extends StatefulWidget {
  final String studentId;
  final String reportId;
  final VoidCallback onSuccess;
  const ReportMonthlyAddResponse({
    super.key,
    required this.onSuccess,
    required this.studentId,
    required this.reportId,
  });

  @override
  State<ReportMonthlyAddResponse> createState() =>
      _ReportMonthlyAddResponseState();
}

class _ReportMonthlyAddResponseState extends State<ReportMonthlyAddResponse> {
  final TextEditingController messageController = TextEditingController();

  bool _isEnable = false;

  void _setEnableButton() {
    bool messagePass = messageController.text.isNotEmpty;
    setState(() {
      _isEnable = messagePass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddMonthlyReportResponseBloc,
        AddMonthlyReportResponseState>(
      listener: (context, state) async {
        if (state is AddMonthlyReportResponseLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is AddMonthlyReportResponseError) {
          Navigator.pop(context);
          SPDialog.showFailure(
            context,
            message: state.message,
          );
        }

        if (state is AddMonthlyReportResponseSuccess) {
          Navigator.pop(context);
          await SPDialog.showSuccess(
            context,
            message: 'Yeay! komentar anda berhasil dibuat',
          ).then(
            (value) => Navigator.pop(context),
          );
          widget.onSuccess();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Berikan komentar anda untuk pihak sekolah pada kolom berikut :',
            style: SPTextStyles.text14W400636363,
          ),
          const SizedBox(height: 12),
          SPTextField(
            controller: messageController,
            hintText: 'Tambah komentar',
            validator: SPValidator.validateEmpty,
            maxLines: 4,
            onChanged: (value) => _setEnableButton(),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SPElevatedButton(
                  type: SPElevatedButtonType.secondary,
                  text: 'Batal',
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SPElevatedButton(
                  text: 'Submit',
                  type: _isEnable
                      ? SPElevatedButtonType.primary
                      : SPElevatedButtonType.disabled,
                  onPressed: () {
                    if (_isEnable) {
                      BlocProvider.of<AddMonthlyReportResponseBloc>(context)
                          .add(
                        AddMonthlyReportResponseEvent(
                          reportId: widget.reportId,
                          studentId: widget.studentId,
                          message: messageController.text,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
