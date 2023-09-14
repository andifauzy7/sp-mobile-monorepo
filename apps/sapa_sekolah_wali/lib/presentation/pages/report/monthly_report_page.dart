import 'package:flutter/material.dart';

class MonthlyReportPage extends StatelessWidget {
  const MonthlyReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Laporan Bulanan',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Name :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Text(
              'Andi Fauzy',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 12,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    renderTitle(
                      color: const Color(0xff31B7BC),
                      title: 'Perkembangan Umum',
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Andi sudah mulai mampu mengikuti aturan, paham ketika diajarkan cara menggunakan benda benda didalam kelas sesuai dengan fungsinya, Andi sangat manis terhadap teman-temannya.",
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    renderTitle(
                      color: const Color(0xff548DD4),
                      title: 'Komunikasi dan Bahasa',
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Jumlah kosa kata yang dipahami oleh Andi sudah banyak yang keluar, namun masih belum terlalu jelas pengucapannya. Kemampuan memahami intruksi-intruksi yang abstrak juga sudah mulai baik.",
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    renderTitle(
                      color: const Color(0xffC53B3B),
                      title: 'Pribadi, Sosial dan Perkembangan Emosional',
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Seiring dengan berkembangnya kemampuan dan kematangan berfikir, Andi mulai belajar mengekspresikan emosi dengan baik. Andi adalah pribadi yang menyenangkan, sehingga mudah sekali bagi Andi menjalin hubungan pertemanan yang baru, bersama teman sebayanya.",
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    renderTitle(
                      color: const Color(0xffFEC000),
                      title: 'Perkembangan Fisik',
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Perkembangan fisik Andi sangat baik dan sesuai tahapan perkembangannya. Namun Andi harus banyak latihan fisik untuk melatih kematangan fokus dan konsentrasi, seperti melompat, berayun, berjalan dipapan titian, dan memanjat.",
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    renderTitle(
                      color: const Color(0xffF79646),
                      title: 'Matematika',
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Sudah bisa menyebutkan angka 1-10, namun Andi belum memahami konsep simbol dan jumlah untuk pengenalan konsep simbol dan jumlah, perlu dimatangkan fokus dan konsentrasi Andi terlebih dahulu. Sementara itu material yang dipakai adalah material-material yang melatih fokus dan konsentrasi.",
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    renderTitle(
                      color: const Color(0xff7031A0),
                      title: 'Norma dan Etika',
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Andi adalah anak yang baik dan patuh, hanya saja masih harus diarahkan dalam melakukan aturan-aturan yang boleh dan tidak boleh. Andi mengerti dan paham jika diajarkan tentang suatu hal.",
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    renderTitle(
                      color: const Color(0xff31849B),
                      title: 'Ekspresi dan Seni',
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Tertarik untuk mengikuti gerak dan lagu. Senang mengikuti lirik lagu yang di nyanyikan di dalam kelas, Andi juga senang saat mengikuti kegiatan zumba didalam kelas.",
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    renderTitle(
                      color: const Color(0xff31B7BC),
                      title: 'Sasaran Pembelajaran yang Akan Datang',
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Fokus dan Konsentrasi : Memakai material-material yang kegunaannya untuk melatih fokus dan konsentrasi Andi seperti, tuang menuang air, menyendok kacang hijau, berjalan dipapan titian, memanjat.",
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextButton(
              onPressed: () => {},
              child: const Text(
                'Tambah Pendapat Orang Tua +',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Container renderTitle({
    required String title,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      color: color,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
