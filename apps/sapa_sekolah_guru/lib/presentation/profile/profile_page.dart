import 'package:flutter/material.dart';
import 'package:sapa_component/card/card_profile_menu.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/logout/logout_bloc.dart';

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
    return SPContainerImage(
      imageUrl: SPAssets.images.circleBackground.path,
      package: spComponentPackage,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => onChangePassword(),
                child: CardProfileMenu(
                  label: 'Ubah Password',
                  icon: SPAssets.icon.arrowRight.path,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => BlocProvider.of<LogoutBloc>(context).add(
                  LogoutEvent(),
                ),
                child: CardProfileMenu(
                  label: 'Keluar',
                  labelStyle: SPTextStyles.text12W400EB5757,
                  icon: SPAssets.icon.logout.path,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
