import 'package:flutter/material.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_shadow.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class SPDropdownField extends StatelessWidget {
  final String hintText;
  final String? value;
  final Widget? suffix, prefix;
  final List<String> items;
  final Function(String? value)? onChanged;
  const SPDropdownField({
    super.key,
    required this.hintText,
    this.suffix,
    this.prefix,
    required this.items,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        color: Colors.white,
        boxShadow: SPShadow.shadowFAFAFA,
      ),
      child: ButtonTheme(
        child: DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          icon: const SizedBox.shrink(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: SPTextStyles.text14W400303030,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: SPTextStyles.text14W400303030,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            prefixIcon: prefix != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: prefix,
                  )
                : null,
            suffixIcon: suffix != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: suffix,
                  )
                : null,
            hintStyle: SPTextStyles.text14W400B3B3B3,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
