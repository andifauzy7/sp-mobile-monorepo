import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sapa_sekolah_guru/bloc/get_permit_type/get_permit_type_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_students/get_students_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_dropdown_field.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_validator.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CreatePermission extends StatefulWidget {
  const CreatePermission({super.key});

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
    print('$datePass $notePass $studentPass $permitPass');
    setState(() {
      _isEnable = datePass && notePass && studentPass && permitPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                items: state.students.map((e) => e.studentName ?? '').toList(),
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
                items:
                    state.permit.map((e) => e.studentLeaveName ?? '').toList(),
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
                            String formatStart = DateFormat("MM/dd/yy").format(
                              startDate,
                            );
                            String formatEnd = DateFormat("MM/dd/yy").format(
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
              if (_isEnable) {}
            },
          ),
        ),
      ],
    );
  }
}
