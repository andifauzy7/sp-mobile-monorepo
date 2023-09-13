import 'package:flutter/material.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/form/sp_dropdown_field.dart';
import 'package:sapa_component/form/sp_text_field.dart';
import 'package:sapa_component/form/sp_validator.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/add_permit/add_permit_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_permit_type/get_permit_type_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_students/get_students_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';

class CreatePermission extends StatefulWidget {
  final VoidCallback onSuccess;
  const CreatePermission({super.key, required this.onSuccess});

  @override
  State<CreatePermission> createState() => _CreatePermissionState();
}

class _CreatePermissionState extends State<CreatePermission> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  String studentId = '';
  String permitId = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  bool _isEnable = false;

  void _setEnableButton() {
    bool datePass = dateController.text.isNotEmpty;
    bool notePass = noteController.text.isNotEmpty;
    bool studentPass = studentId.isNotEmpty;
    bool permitPass = permitId.isNotEmpty;
    setState(() {
      _isEnable = datePass && notePass && studentPass && permitPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPermitBloc, AddPermitState>(
      listener: (context, state) async {
        if (state is AddPermitLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is AddPermitError) {
          Navigator.pop(context);
          SPDialog.showFailure(
            context,
            message: state.message,
          );
        }

        if (state is AddPermitSuccess) {
          Navigator.pop(context);
          await SPDialog.showSuccess(
            context,
            message: 'Yeay! Anda berhasil menambahkan izin siswa',
          ).then(
            (value) => Navigator.pop(context),
          );
          widget.onSuccess();
        }
      },
      child: Column(
        children: [
          Text(
            'Pemberian Izin Murid',
            style: SPTextStyles.text14W400303030,
          ),
          const SizedBox(height: 12),
          BlocBuilder<GetStudentsBloc, GetStudentsState>(
            builder: (context, state) {
              if (state is GetStudentsError) {
                return Text(state.message);
              }
              if (state is GetStudentsSuccess) {
                return SPDropdownField(
                  items:
                      state.students.map((e) => e.studentName ?? '').toList(),
                  hintText: 'Tambah Murid',
                  suffix: SvgPicture.asset(
                    Assets.icon.addSquare.path,
                  ),
                  onChanged: (value) {
                    setState(() {
                      studentId = state.students
                          .where((element) => element.studentName == value)
                          .first
                          .studentId
                          .toString();
                    });
                    _setEnableButton();
                  },
                );
              }
              return const CircularProgressIndicator();
            },
          ),
          const SizedBox(height: 10),
          BlocBuilder<GetPermitTypeBloc, GetPermitTypeState>(
            builder: (context, state) {
              if (state is GetPermitTypeError) {
                return Text(state.message);
              }
              if (state is GetPermitTypeSuccess) {
                return SPDropdownField(
                  items: state.permit
                      .map((e) => e.studentLeaveName ?? '')
                      .toList(),
                  hintText: 'Tipe Izin',
                  suffix: SvgPicture.asset(
                    Assets.icon.addSquare.path,
                  ),
                  onChanged: (value) {
                    setState(() {
                      permitId = state.permit
                          .where((element) => element.studentLeaveName == value)
                          .first
                          .studentLeaveId
                          .toString();
                    });
                    _setEnableButton();
                  },
                );
              }
              return const CircularProgressIndicator();
            },
          ),
          const SizedBox(height: 10),
          SPTextField(
            controller: dateController,
            hintText: 'Pilih Tanggal',
            enabled: false,
            suffix: SvgPicture.asset(
              Assets.icon.calendarPicker.path,
            ),
            onTap: () async {
              await showDialog<Widget>(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width - 40,
                      height: MediaQuery.of(context).size.height / 2,
                      color: Colors.white,
                      child: SfDateRangePicker(
                        initialSelectedRange: PickerDateRange(
                          startDate,
                          endDate,
                        ),
                        view: DateRangePickerView.month,
                        selectionMode: DateRangePickerSelectionMode.range,
                        showActionButtons: true,
                        cancelText: 'CANCEL',
                        confirmText: 'OK',
                        onCancel: () => Navigator.pop(context),
                        onSubmit: (args) {
                          if (args != null && args is PickerDateRange) {
                            setState(() {
                              startDate = args.startDate!;
                              endDate = args.endDate!;
                              String formatStart =
                                  DateFormat("dd/MM/yy").format(
                                startDate,
                              );
                              String formatEnd = DateFormat("dd/MM/yy").format(
                                endDate,
                              );
                              dateController.text = '$formatStart - $formatEnd';
                              _setEnableButton();
                            });
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 10),
          SPTextField(
            controller: noteController,
            hintText: 'Tambah keterangan',
            validator: SPValidator.validateEmpty,
            maxLines: 4,
            onChanged: (value) => _setEnableButton(),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: SPElevatedButton(
              text: 'Submit',
              type: _isEnable
                  ? SPElevatedButtonType.primary
                  : SPElevatedButtonType.disabled,
              onPressed: () {
                if (_isEnable) {
                  BlocProvider.of<AddPermitBloc>(context).add(
                    AddPermitEvent(
                      studentId: studentId,
                      permitType: permitId,
                      dateStart: startDate,
                      dateEnd: endDate,
                      notes: noteController.text,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
