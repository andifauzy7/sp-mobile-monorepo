import 'package:flutter/material.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/form/sp_text_field.dart';
import 'package:sapa_component/form/sp_validator.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/add_consultation_response/add_consultation_response_bloc.dart';

class ConsultationAddResponse extends StatefulWidget {
  final String consultationId;
  final VoidCallback onSuccess;
  const ConsultationAddResponse({
    super.key,
    required this.onSuccess,
    required this.consultationId,
  });

  @override
  State<ConsultationAddResponse> createState() =>
      _ConsultationAddResponseState();
}

class _ConsultationAddResponseState extends State<ConsultationAddResponse> {
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
    return BlocListener<AddConsultationResponseBloc,
        AddConsultationResponseState>(
      listener: (context, state) async {
        if (state is AddConsultationResponseLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is AddConsultationResponseError) {
          Navigator.pop(context);
          SPDialog.showFailure(
            context,
            message: state.message,
          );
        }

        if (state is AddConsultationResponseSuccess) {
          Navigator.pop(context);
          await SPDialog.showSuccess(
            context,
            message: 'Yeay! Anda berhasil mengirim tanggapan anda',
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
            'Tambahkan Tanggapan',
            style: SPTextStyles.text14W400636363,
          ),
          const SizedBox(height: 12),
          SPTextField(
            controller: messageController,
            hintText: 'Tambah tanggapan',
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
                      BlocProvider.of<AddConsultationResponseBloc>(context).add(
                        AddConsultationResponseEvent(
                          consultationId: widget.consultationId,
                          responseText: messageController.text,
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
