import 'package:flutter/material.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';

class SPDateField extends StatefulWidget {
  final Function(DateTime value) onChanged;
  const SPDateField({
    super.key,
    required this.onChanged,
  });

  @override
  State<SPDateField> createState() => _SPDateFieldState();
}

class _SPDateFieldState extends State<SPDateField> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: SPShadow.shadowGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tanggal',
            style: SPTextStyles.text12W400B3B3B3,
          ),
          GestureDetector(
            onTap: () async {
              DateTime? result = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.utc(2010, 10, 16),
                lastDate: DateTime.now(),
              );

              if (result != null) {
                setState(() {
                  dateTime = result;
                  widget.onChanged(dateTime);
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('d MMMM y', 'id_ID').format(
                    dateTime,
                  ),
                  style: SPTextStyles.text14W400303030,
                ),
                SvgPicture.asset(
                  SPAssets.icon.calendarPicker.path,
                  package: spComponentPackage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
