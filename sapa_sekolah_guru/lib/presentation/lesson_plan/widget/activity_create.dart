import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/add_activity/add_activity_bloc.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/dialog/sp_dialog.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class ActivityCreate extends StatefulWidget {
  final VoidCallback onSuccess;
  const ActivityCreate({super.key, required this.onSuccess});

  @override
  State<ActivityCreate> createState() => _ActivityCreateState();
}

class _ActivityCreateState extends State<ActivityCreate> {
  final TextEditingController activityController = TextEditingController();

  bool _isEnable = false;

  void _setEnableButton() {
    bool activities = activityController.text.isNotEmpty;
    setState(() {
      _isEnable = activities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddActivityBloc, AddActivityState>(
      listener: (context, state) async {
        if (state is AddActivityLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is AddActivityError) {
          Navigator.pop(context);
          SPDialog.showFailure(
            context,
            message: state.message,
          );
        }

        if (state is AddActivitySuccess) {
          Navigator.pop(context);
          await SPDialog.showSuccess(
            context,
            message: 'Yeay! Anda berhasil menambahkan daftar aktivitas baru',
          ).then(
            (value) => Navigator.pop(context),
          );
          widget.onSuccess();
        }
      },
      child: Column(
        children: [
          Text(
            'Tambah Aktivitas',
            style: SPTextStyles.text16W400BLACK,
          ),
          const SizedBox(height: 16),
          SPTextField(
            hintText: 'Nama aktivitas',
            controller: activityController,
            onChanged: (_) => _setEnableButton(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: SPElevatedButton(
              text: 'Buat',
              onPressed: _isEnable
                  ? () => BlocProvider.of<AddActivityBloc>(context).add(
                        AddActivityEvent(
                          activity: activityController.text,
                        ),
                      )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
