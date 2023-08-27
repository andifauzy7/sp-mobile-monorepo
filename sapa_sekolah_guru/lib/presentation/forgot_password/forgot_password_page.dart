import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sapa_sekolah_guru/bloc/change_password/change_password_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/presentation/splash/splash_page.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/dialog/sp_dialog.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_validator.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_container_image.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';
import 'package:sapa_sekolah_guru/shared/component/toast/sp_toast.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<ChangePasswordBloc>(),
      child: const _ForgotPasswordPageBody(),
    );
  }
}

class _ForgotPasswordPageBody extends StatefulWidget {
  const _ForgotPasswordPageBody({super.key});

  @override
  State<_ForgotPasswordPageBody> createState() =>
      __ForgotPasswordPageBodyState();
}

class __ForgotPasswordPageBodyState extends State<_ForgotPasswordPageBody> {
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  bool _isEnable = false;

  void _setEnableButton() {
    bool oldPass = oldPassword.text.isNotEmpty;
    bool newPass = newPassword.text.isNotEmpty;
    bool confirmPass = confirmPassword.text.isNotEmpty;
    setState(() {
      _isEnable = oldPass &&
          newPass &&
          confirmPass &&
          (newPassword.text == confirmPassword.text);
    });
  }

  void _navigateToSplash(
    BuildContext context,
  ) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const SplashPage(),
        ),
        (route) => false,
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is ChangePasswordError) {
          Navigator.pop(context);
          SPToast.showToast(message: state.message);
        }

        if (state is ChangePasswordSuccess) {
          Navigator.pop(context);
          _navigateToSplash(context);
        }
      },
      child: Scaffold(
        backgroundColor: SPColors.colorFAFAFA,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: SPTextField(
                      controller: oldPassword,
                      hintText: 'Masukan password lama anda',
                      validator: SPValidator.validateEmpty,
                      onChanged: (_) => _setEnableButton(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: SPTextField(
                      controller: newPassword,
                      hintText: 'Buat password baru anda',
                      validator: SPValidator.validateEmpty,
                      onChanged: (_) => _setEnableButton(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: SPTextField(
                      controller: confirmPassword,
                      hintText: 'Konfirmasi password',
                      validator: (value) => SPValidator.validateReTypePassword(
                        value,
                        newPassword.text,
                      ),
                      onChanged: (_) => _setEnableButton(),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: SPElevatedButton(
                      type: _isEnable
                          ? SPElevatedButtonType.primary
                          : SPElevatedButtonType.disabled,
                      text: 'Simpan',
                      onPressed: () {
                        if (_isEnable) {
                          BlocProvider.of<ChangePasswordBloc>(context).add(
                            ChangePasswordEvent(
                              oldPassword: oldPassword.text,
                              newPassword: newPassword.text,
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
