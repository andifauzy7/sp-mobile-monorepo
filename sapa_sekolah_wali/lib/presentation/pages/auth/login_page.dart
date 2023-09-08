import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapa_sekolah_wali/application/bloc/auth/auth_bloc.dart';
import 'package:sapa_sekolah_wali/dependency.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/button/primary_button.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/dialog/error_dialog.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/dialog/loading_dialog.dart';
import 'package:sapa_sekolah_wali/presentation/utils/routes/route_utils.dart';
import 'package:sapa_sekolah_wali/presentation/utils/style/style_utils.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthBloc authBloc = getIt<AuthBloc>();

  final formGroup = fb.group({
    'username': ['', Validators.required],
    'password': ['', Validators.required]
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => authBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.map(
            initial: (initial) {},
            loading: (loading) {
              showLoadingDialog(context);
            },
            success: (success) {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, RouteName.home);
            },
            failure: (failure) {
              Navigator.pop(context);
              showErrorDialog(context, failure.message);
            },
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xfff2bfbf),
                Color(0xffe16cb3),
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: true,
            ),
            body: ReactiveFormBuilder(
                form: () => formGroup,
                builder: (context, formGroup, child) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 36),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Username',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ReactiveTextField(
                                formControlName: 'username',
                                decoration: StyleUtils.inputDecoration(
                                    'Masukkan Username Disini'),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Password',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ReactiveTextField(
                                formControlName: 'password',
                                obscureText: true,
                                decoration: StyleUtils.inputDecoration(
                                    'Masukkan Password Disini'),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 18),
                              ReactiveFormConsumer(
                                builder: (context, fomrGroup, child) {
                                  return PrimaryButton(
                                    title: 'Masuk',
                                    isActive: formGroup.valid,
                                    onTap: () {
                                      authBloc.add(
                                          AuthEvent.login(formGroup.value));
                                    },
                                  );
                                },
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 10),
                              const Center(
                                child: Text(
                                  'Kesulitan Untuk Masuk ?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Center(
                                child: InkWell(
                                  onTap: () {},
                                  child: const Text(
                                    'Hubungi Admin',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
