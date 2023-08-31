import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class StudentPresenceRow extends StatefulWidget {
  final String name;
  final bool isPresence;
  const StudentPresenceRow({
    super.key,
    required this.name,
    required this.isPresence,
  });

  @override
  State<StudentPresenceRow> createState() => _StudentPresenceRowState();
}

class _StudentPresenceRowState extends State<StudentPresenceRow> {
  bool isSelected = false;

  @override
  void initState() {
    isSelected = widget.isPresence;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: SPTextStyles.text10W400303030,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                // group
                "",
                style: SPTextStyles.text10W400B3B3B3,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            isSelected == true ? "Hadir" : "Belum Hadir",
            style: SPTextStyles.text10W400303030,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => setState(() {
              isSelected = !isSelected;
            }),
            child: isSelected == true
                ? SvgPicture.asset(
                    Assets.icon.trueCheckbox.path,
                  )
                : SvgPicture.asset(
                    Assets.icon.emptyCheckbox.path,
                  ),
          ),
        ),
      ],
    );
    ;
  }
}
