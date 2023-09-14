import 'package:flutter/material.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/form/sp_text_field.dart';
import 'package:sapa_component/form/sp_validator.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/toast/sp_toast.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/login/login_bloc.dart';
import 'package:sapa_sekolah_wali/gen/assets.gen.dart';
import 'package:sapa_sekolah_wali/presentation/main/main_page.dart';

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
  const _LoginPageBody();

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
              imageUrl: SPAssets.images.dotOrnament.path,
              package: spComponentPackage,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: SizedBox(
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              Assets.images.logoLittleCastle.path,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Kontrol anak lebih mudah\nmelalui Aplikasi SAPA Sekolah',
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
