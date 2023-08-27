import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sapa_sekolah_guru/bloc/login/login_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/presentation/main/main_page.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/dialog/sp_dialog.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_validator.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_container_image.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';
import 'package:sapa_sekolah_guru/shared/component/toast/sp_toast.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<LoginBloc>(),
      child: const _LoginPageBody(),
    );
  }
}

class _LoginPageBody extends StatefulWidget {
  const _LoginPageBody({Key? key}) : super(key: key);

  @override
  State<_LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<_LoginPageBody> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool _isEnable = false;

  void _setEnableButton() {
    bool namePass = nameController.text.isNotEmpty;
    bool passPass = passController.text.isNotEmpty;
    setState(() {
      _isEnable = namePass && passPass;
    });
  }

  void _navigateToMain(
    BuildContext context,
  ) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const MainPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is LoginError) {
          Navigator.pop(context);
          SPToast.showToast(message: state.message);
        }

        if (state is LoginSuccess) {
          Navigator.pop(context);
          _navigateToMain(context);
        }
      },
      child: Scaffold(
        backgroundColor: SPColors.colorFAFAFA,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SPContainerImage(
              imageUrl: Assets.images.loginOrnament.path,
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Stack(
                      children: [
                        Center(
                          child: Transform.translate(
                            offset: Offset(
                              MediaQuery.of(context).size.width * 0.3,
                              -MediaQuery.of(context).size.height * 0.1,
                            ),
                            child: Transform.rotate(
                              angle: -math.pi / 4,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                color: SPColors.colorFFF1E6,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                Assets.images.loginBackground.path,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Kontrol siswa lebih mudah\nmelalui Aplikasi SAPA Sekolah',
                    textAlign: TextAlign.center,
                    style: SPTextStyles.text16W400303030,
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: SPTextField(
                      controller: nameController,
                      hintText: 'Input username anda',
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
                      controller: passController,
                      obscureText: true,
                      hintText: 'Password, contoh Rendy@123',
                      validator: SPValidator.validateEmpty,
                      onChanged: (_) => _setEnableButton(),
                    ),
                  ),
                  /*
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: GestureDetector(
                      onTap: () => _navigateToForgotPassword(context),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Lupa Password?',
                          style: SPTextStyles.text12W400B3B3B3,
                        ),
                      ),
                    ),
                  ),*/
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: SPElevatedButton(
                      type: _isEnable
                          ? SPElevatedButtonType.primary
                          : SPElevatedButtonType.disabled,
                      onPressed: () {
                        if (_isEnable) {
                          BlocProvider.of<LoginBloc>(context).add(
                            LoginEvent(
                              username: nameController.text,
                              password: passController.text,
                            ),
                          );
                        }
                      },
                      text: 'Masuk',
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
