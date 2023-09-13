import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapa_sekolah_wali/application/bloc/child/child_bloc.dart';
import 'package:sapa_sekolah_wali/dependency.dart';

class DetailTeacherPage extends StatefulWidget {
  const DetailTeacherPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailTeacherPage> createState() => _DetailTeacherPageState();
}

class _DetailTeacherPageState extends State<DetailTeacherPage> {
  final bloc = getIt<ChildBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(const ChildEvent.load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChildBloc>(
      create: (_) => bloc,
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height * 0.4) + 16,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffe16cb3),
                      Color(0xfff2bfbf),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: (MediaQuery.of(context).size.height * 0.4),
                      child: Column(
                        children: [
                          SafeArea(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Profil Guru',
                                  style: TextStyle(color: Colors.white),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Image.network(
                                'https://lc.sapasekolah.com//document/employee/-_E95XpUn.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Yolanda Elmus Pita',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text('Guru'),
                          /*
                          SizedBox(height: 8),
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
