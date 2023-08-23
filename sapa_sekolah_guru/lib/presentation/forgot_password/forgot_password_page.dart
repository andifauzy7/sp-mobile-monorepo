import 'package:flutter/material.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_container_image.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SPContainerImage(
            imageUrl: Assets.images.forgotPasswordOrnament.path,
            child: Column(
              children: [
                const SizedBox(height: 32),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        Assets.images.forgotPasswordBackground.path,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Perbaharui Password Anda',
                  textAlign: TextAlign.center,
                  style: SPTextStyles.text16W400636363,
                ),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: SPTextField(
                    hintText: 'Masukan password lama anda',
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: SPTextField(
                    hintText: 'Buat password baru anda',
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: SPTextField(
                    hintText: 'Konfirmasi password',
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: SPElevatedButton(
                    text: 'Simpan',
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
