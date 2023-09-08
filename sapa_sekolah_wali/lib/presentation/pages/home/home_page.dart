import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sapa_sekolah_wali/application/bloc/news/news_bloc.dart';
import 'package:sapa_sekolah_wali/dependency.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/card/activity_card.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/card/news_card.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/card/shimmer_card.dart';
import 'package:sapa_sekolah_wali/presentation/utils/routes/route_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final NewsBloc newsBloc = getIt<NewsBloc>();

  @override
  void initState() {
    super.initState();
    newsBloc.add(const NewsEvent.load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => newsBloc,
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 42,
              horizontal: 18,
            ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.changePassword);
                  },
                  child: const Text(
                    'Ubah Password',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text('Keluar',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              _key.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Welcome 👋',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              'https://sm.ign.com/ign_ap/cover/a/avatar-gen/avatar-generations_hugw.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Hi, ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Parents',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pilih Aktivitas',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 96,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ActivityCardRow(
                        color: const Color(0xffFF9800),
                        label: 'Data\nMurid',
                        icon: Icons.person,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteName.listChild,
                            arguments: 'detail-child',
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      ActivityCardRow(
                        color: const Color(0xff465783),
                        label: 'Data\nGuru',
                        icon: Icons.person,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteName.listTeacher,
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      ActivityCardRow(
                        color: const Color(0xff2196F3),
                        label: 'Pemba-\nyaran',
                        icon: Icons.credit_card,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteName.listChild,
                            arguments: 'payment',
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      ActivityCardRow(
                        color: const Color(0xff9C27B0),
                        label: 'Laporan\nHarian',
                        icon: Icons.edit_document,
                        onTap: () => Navigator.pushNamed(
                          context,
                          RouteName.listChild,
                          arguments: 'daily-report',
                        ),
                      ),
                      const SizedBox(width: 8),
                      ActivityCardRow(
                        color: const Color(0xff4CAF50),
                        label: 'Laporan\nBulanan',
                        icon: Icons.edit_document,
                        onTap: () => Navigator.pushNamed(
                          context,
                          RouteName.listChild,
                          arguments: 'monthly-report',
                        ),
                      ),
                      const SizedBox(width: 8),
                      ActivityCardRow(
                        color: const Color(0xffE91E63),
                        label: 'Monte-\nssori',
                        icon: Icons.document_scanner,
                        onTap: () => Navigator.pushNamed(
                          context,
                          RouteName.listChild,
                          arguments: 'montessori-report',
                        ),
                      ),
                      const SizedBox(width: 8),
                      const ActivityCardRow(
                        color: Color(0xff607D8B),
                        label: 'Rekap\nAbsen',
                        icon: Icons.access_time,
                      ),
                    ],
                  ),
                ),
                /*
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ActivityCard(
                        icons: Icons.people,
                        title: '',
                        subtitle: 'Data Murid',
                        backgroundColor: const Color(0xffFF9800),
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.listChild,
                              arguments: 'detail-child');
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ActivityCard(
                        icons: Icons.credit_card,
                        title: DateFormat('MMM yyyy').format(DateTime.now()),
                        subtitle: 'Pembayaran',
                        backgroundColor: const Color(0xff2196F3),
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.listChild,
                              arguments: 'payment');
                        },
                      ),
                    ),
                    /*
                    Expanded(
                      child: ActivityCard(
                        icons: CupertinoIcons.book,
                        title: DateFormat('dd MMM yyyy').format(DateTime.now()),
                        subtitle: 'Jadwal KBM',
                        backgroundColor: const Color(0xff2196F3),
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.studySchedule);
                        },
                      ),
                    ),*/
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ActivityCard(
                        icons: Icons.edit_document,
                        title: DateFormat('dd MMM yyyy').format(DateTime.now()),
                        subtitle: 'Laporan Harian',
                        backgroundColor: const Color(0xff9C27B0),
                        onTap: () => Navigator.pushNamed(
                          context,
                          RouteName.listChild,
                          arguments: 'daily-report',
                        ),
                      ),
                    ),
                    /*
                    Expanded(
                      child: ActivityCard(
                        icons: Icons.credit_card,
                        title: DateFormat('dd MMM yyyy').format(DateTime.now()),
                        subtitle: 'Pembayaran',
                        backgroundColor: const Color(0xff9C27B0),
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.listChild,
                              arguments: 'payment');
                        },
                      ),
                    ),
                    */
                    const SizedBox(width: 12),
                    Expanded(
                      child: ActivityCard(
                        icons: Icons.edit_document,
                        title: DateFormat('MMM yyyy').format(DateTime.now()),
                        subtitle: 'Laporan Bulanan',
                        backgroundColor: const Color(0xff4CAF50),
                        onTap: () => Navigator.pushNamed(
                          context,
                          RouteName.listChild,
                          arguments: 'monthly-report',
                        ),
                      ),
                    ),
                    /*
                    Expanded(
                      child: ActivityCard(
                        icons: Icons.calendar_month,
                        title: DateFormat('dd MMM yyyy').format(DateTime.now()),
                        subtitle: 'Jadwal Mudifah',
                        backgroundColor: const Color(0xff4CAF50),
                      ),
                    ),
                    */
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ActivityCard(
                        icons: Icons.document_scanner,
                        title: DateFormat('MMM yyyy').format(DateTime.now()),
                        subtitle: 'Laporan Montessori',
                        backgroundColor: const Color(0xffE91E63),
                        onTap: () => Navigator.pushNamed(
                          context,
                          RouteName.listChild,
                          arguments: 'montessori-report',
                        ),
                      ),
                    ),
                    /*
                    const Expanded(
                      child: ActivityCard(
                        icons: Icons.account_balance_wallet_outlined,
                        title: 'RP 150.000',
                        subtitle: 'Uang Saku',
                        backgroundColor: Color(0xffE91E63),
                      ),
                    ),*/
                    const SizedBox(width: 12),
                    const Expanded(
                      child: ActivityCard(
                        icons: Icons.access_time,
                        title: '',
                        subtitle: 'Absensi',
                        backgroundColor: Color(0xff607D8B),
                      ),
                    ),
                    /*
                    const Expanded(
                      child: ActivityCard(
                        icons: Icons.monetization_on,
                        title: '',
                        subtitle: 'Donasi',
                        backgroundColor: Color(0xff607D8B),
                      ),
                    ),
                    */
                  ],
                ),
                */
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi Sekolah',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Terbaru Seputar Little Castle',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: const [
                        NewsCardRow(
                          color: Color(0xffFF9800),
                          imageUrl:
                              'https://i.pinimg.com/736x/c3/4c/0a/c34c0ab148d15b45f6136bdf5c8cf3da.jpg',
                          label: 'Bayaran',
                          title: 'Pembayaran Juli',
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        NewsCardRow(
                          color: Color(0xff2196F3),
                          imageUrl:
                              'https://plus.unsplash.com/premium_photo-1663126441273-07d4d172c41d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c2Nob29sJTIwY2hpbGRyZW58ZW58MHx8MHx8fDA%3D&w=1000&q=80',
                          label: 'Data Murid',
                          title: 'Lengkapi Data Murid Sekarang',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: const [
                        NewsCardRow(
                          color: Color(0xff9C27B0),
                          imageUrl:
                              'https://www.americanlycetuffdnk.edu.pk/wp-content/uploads/2023/02/als-dnk.jpg',
                          label: 'Aktifitas',
                          title: 'Aktifitas Siswa di Bulan Juli',
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        NewsCardRow(
                          color: Color(0xff4CAF50),
                          imageUrl:
                              'https://images.template.net/wp-content/uploads/2015/12/20071035/Free-Newspaper-Template.jpeg',
                          label: 'Laporan',
                          title: 'Nilai Akhir Siswa Periode Juli',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: const [
                        NewsCardRow(
                          color: Color(0xffE91E63),
                          imageUrl:
                              'https://www.parents.com/thmb/TBZZwMQhIzcUtMmdjSUgKprqoNY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/shutterstock_655869010-339273ff7e614665bb0f7ad49d6580cc.jpg',
                          label: 'Aktifitas',
                          title: 'Study Tour Siswa Bulan Juni',
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        NewsCardRow(
                          color: Color(0xff607D8B),
                          imageUrl:
                              'https://images.template.net/wp-content/uploads/2015/12/20071035/Free-Newspaper-Template.jpeg',
                          label: 'Data Murid',
                          title: 'Lengkapi data murid sekarang',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                /*
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi Seputar Sekolah',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Berita Terbaru Seputar Little Castle',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<NewsBloc, NewsState>(
                      builder: (context, state) {
                        return state.map(
                          initial: (_) {
                            return SingleChildScrollView(
                              child: Column(
                                children: const [
                                  ShimmerCard(height: 175),
                                  ShimmerCard(height: 175),
                                  ShimmerCard(height: 175),
                                ],
                              ),
                            );
                          },
                          loading: (_) {
                            return SingleChildScrollView(
                              child: Column(
                                children: const [
                                  ShimmerCard(height: 175),
                                  ShimmerCard(height: 175),
                                  ShimmerCard(height: 175),
                                ],
                              ),
                            );
                          },
                          failure: (failure) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    'assets/others/lottie_error.json',
                                    height: 175,
                                    width: 175,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 12),
                                  SelectableText(failure.message,
                                      textAlign: TextAlign.center)
                                ],
                              ),
                            );
                          },
                          succcess: (succcess) {
                            return SingleChildScrollView(
                              child: Column(
                                children: succcess.payload
                                    .map((e) => NewsCard(title: e.newsTitle))
                                    .toList(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                */
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewsCardRow extends StatelessWidget {
  final Color color;
  final String label;
  final String title;
  final String imageUrl;
  const NewsCardRow({
    super.key,
    required this.color,
    required this.label,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityCardRow extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const ActivityCardRow({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
