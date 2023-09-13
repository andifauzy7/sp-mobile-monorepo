import 'package:flutter/material.dart';

class AddParentOpinionPage extends StatelessWidget {
  const AddParentOpinionPage({super.key});

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
          'Komentar',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.send,
              color: Colors.black,
            ),
          ),
        ],
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
              'Pendapat Orang Tua',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Text(
              'Mohon tinggalkan komentar untuk pihak sekolah pada kolom berikut:',
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
                      title: 'Komentar Orang Tua',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        minLines: 4,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tambahkan disini ... ',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Kami mengucapkan terimakasih atas kesempatan dan dukungan yang diberikan untuk membersamai ananda.',
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
