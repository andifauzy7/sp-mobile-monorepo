import 'package:flutter/material.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/add_lesson/add_lesson_bloc.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/form/sp_text_field.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class LessonCreate extends StatefulWidget {
  final VoidCallback onSuccess;
  const LessonCreate({super.key, required this.onSuccess});

  @override
  State<LessonCreate> createState() => _LessonCreateState();
}

class _LessonCreateState extends State<LessonCreate> {
  final TextEditingController lessonController = TextEditingController();

  bool _isEnable = false;

  void _setEnableButton() {
    bool lesson = lessonController.text.isNotEmpty;
    setState(() {
      _isEnable = lesson;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddLessonBloc, AddLessonState>(
      listener: (context, state) async {
        if (state is AddLessonLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is AddLessonError) {
          Navigator.pop(context);
          SPDialog.showFailure(
            context,
            message: state.message,
          );
        }

        if (state is AddLessonSuccess) {
          Navigator.pop(context);
          await SPDialog.showSuccess(
            context,
            message: 'Yeay! Anda berhasil menambahkan daftar pelajaran baru',
          ).then(
            (value) => Navigator.pop(context),
          );
          widget.onSuccess();
        }
      },
      child: Column(
        children: [
          Text(
            'Tambah Area Pengembangan',
            style: SPTextStyles.text16W400BLACK,
          ),
          const SizedBox(height: 16),
          SPTextField(
            hintText: 'Nama area pengembangan',
            controller: lessonController,
            onChanged: (_) => _setEnableButton(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: SPElevatedButton(
              text: 'Buat',
              onPressed: _isEnable
                  ? () => BlocProvider.of<AddLessonBloc>(context).add(
                        AddLessonEvent(
                          lesson: lessonController.text,
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
