import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapa_sekolah_wali/application/bloc/change_password/change_password_cubit.dart';
import 'package:sapa_sekolah_wali/dependency.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../components/global/button/primary_button.dart';
import '../../components/global/dialog/error_dialog.dart';
import '../../components/global/dialog/loading_dialog.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({Key? key}) : super(key: key);

  final bloc = getIt<ChangePasswordCubit>();

  final formGroup = fb.group({
    'existing_password': ['', Validators.required],
    'new_password': ['', Validators.required],
    'confirm_new_password': ['', Validators.required],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Ubah Password',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            state.map(
              initial: (initial) {},
              loading: (loading) {
                showLoadingDialog(context);
              },
              success: (success) {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              failure: (failure) {
                Navigator.pop(context);
                showErrorDialog(context, failure.message);
              },
            );
          },
          child: ReactiveFormBuilder(
              form: () => formGroup,
              builder: (context, formGroup, child) {
                return Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      ReactiveTextField(
                        formControlName: 'existing_password',
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Old Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ReactiveTextField(
                        formControlName: 'new_password',
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'New Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ReactiveTextField(
                        formControlName: 'confirm_new_password',
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Repeat Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ReactiveFormConsumer(
                        builder: (context, fomrGroup, child) {
                          return PrimaryButton(
                            title: 'Masuk',
                            isActive: formGroup.valid,
                            onTap: () {
                              bloc.changePassword(formGroup.value);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
