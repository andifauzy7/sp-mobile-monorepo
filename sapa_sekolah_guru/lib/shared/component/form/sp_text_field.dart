import 'package:flutter/material.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_shadow.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class SPTextField extends StatefulWidget {
  final VoidCallback? onTap;
  final bool? enabled;
  final String hintText;
  final String? Function(String? value)? validator;
  final Function(String value)? onChanged;
  final TextEditingController? controller;
  final int? maxLines;
  final bool obscureText;
  final Widget? suffix, prefix;
  const SPTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.onChanged,
    this.maxLines = 1,
    this.suffix,
    this.prefix,
    this.enabled,
    this.onTap,
  }) : super(key: key);

  @override
  State<SPTextField> createState() => _SPTextFieldState();
}

class _SPTextFieldState extends State<SPTextField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            color: Colors.white,
            boxShadow: SPShadow.shadowFAFAFA,
          ),
          child: GestureDetector(
            onTap: widget.onTap,
            child: TextFormField(
              enabled: widget.enabled,
              obscureText: widget.obscureText,
              controller: widget.controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
                if (widget.validator != null) {
                  _errorText = widget.validator!(value);
                }
              },
              maxLines: widget.maxLines,
              style: SPTextStyles.text14W400303030,
              decoration: InputDecoration(
                isDense: true,
                fillColor: Colors.white,
                hintText: widget.hintText,
                prefixIcon: widget.prefix != null
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: widget.prefix,
                      )
                    : null,
                suffixIcon: widget.suffix != null
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: widget.suffix,
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
        ),
        (_errorText?.isNotEmpty ?? false)
            ? Column(
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      _errorText!,
                      style: SPTextStyles.text12W400EB5757,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
