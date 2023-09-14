import 'package:flutter/material.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/logout/logout_bloc.dart';

class ProfilePage extends StatelessWidget {
  final VoidCallback onLogout, onChangePassword;
  const ProfilePage({
    super.key,
    required this.onLogout,
    required this.onChangePassword,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<LogoutBloc>(),
      child: BlocListener<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            onLogout();
          }
        },
        child: _ProfilePageBody(onChangePassword),
      ),
    );
  }
}

class _ProfilePageBody extends StatelessWidget {
  final VoidCallback onChangePassword;
  const _ProfilePageBody(this.onChangePassword);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => onChangePassword(),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ubah Password',
                      style: SPTextStyles.text12W400303030,
                    ),
                    SvgPicture.asset(
                      SPAssets.icon.arrowRight.path,
                      package: 'sapa_component',
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => BlocProvider.of<LogoutBloc>(context).add(
                LogoutEvent(),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Keluar',
                      style: SPTextStyles.text12W400EB5757,
                    ),
                    SvgPicture.asset(
                      SPAssets.icon.logout.path,
                      package: 'sapa_component',
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
