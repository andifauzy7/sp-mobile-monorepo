import 'package:flutter/material.dart';

class SemesterReportPage extends StatelessWidget {
  const SemesterReportPage({super.key});

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
          'Laporan Semester',
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
              "Student's Name :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Text(
              'Andi Fauzy Dewantara',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Teacher's Name :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Text(
              'Mr. Fauzy Dewantara, S.Psi',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Age :",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '6y 0m',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Quarter :",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '2',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              '(I- Introduced, H- Having Difficulty, WA- Working with Assistance, WI- Working Independently, P- Proficient)',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 8,
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
                      title: '1. Sensorial',
                    ),
                    renderSubtitleRow(),
                    renderOptionRow(
                      isFilled: true,
                      label: 'The Knobbed Cylinders',
                      q2: 'W1',
                    ),
                    renderOptionRow(
                      label: 'Knobbed Cylinders Activity',
                      q2: 'W1',
                    ),
                    renderOptionRow(
                      isFilled: true,
                      label: 'The Pink Tower',
                      q2: 'W1',
                    ),
                    renderOptionRow(
                      label: 'The Pink Tower (Exercise)',
                      q2: '-',
                    ),
                    renderOptionRow(
                      isFilled: true,
                      label: 'The Brown Stairs',
                      q2: 'W1',
                    ),
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
                      title: '2. Practical Life',
                    ),
                    renderSubtitleRow(
                      title: 'A. Elementary Movement',
                    ),
                    renderOptionRow(
                      isFilled: true,
                      label: 'Dry Pouring One to One',
                      q2: 'W1',
                    ),
                    renderOptionRow(
                      label: 'Pegging',
                      q2: 'P',
                    ),
                    renderOptionRow(
                      isFilled: true,
                      label: 'Pounding',
                      q2: 'P',
                    ),
                    renderOptionRow(
                      label: 'Unblocking and Locking Padlock',
                      q2: 'WI',
                    ),
                    renderSubtitleRow(
                      title: 'B. Care Of Person',
                    ),
                    renderOptionRow(
                      isFilled: true,
                      label: 'Blowing Nose',
                      q2: 'WI',
                    ),
                    renderOptionRow(
                      label: 'Washing Hands at Sink',
                      q2: 'WI',
                    ),
                    renderOptionRow(
                      isFilled: true,
                      label: 'Washing Clothes',
                      q2: 'WA',
                    ),
                    renderOptionRow(
                      label: 'Napkin Folding',
                      q2: 'WI',
                    ),
                    renderSubtitleRow(
                      title: 'C. Care Of Environment',
                    ),
                    renderOptionRow(
                      isFilled: true,
                      label: 'Rolling up a Mat',
                      q2: 'WI',
                    ),
                    renderOptionRow(
                      label: 'Carrying a Mat',
                      q2: 'P',
                    ),
                    renderOptionRow(
                      isFilled: true,
                      label: 'Unrolling a Mat',
                      q2: 'WA',
                    ),
                    renderOptionRow(
                      label: 'Carrying a Tray',
                      q2: 'WI',
                    ),
                    renderSubtitleRow(
                      title: 'D. Grace & Courtesy',
                    ),
                    renderOptionRow(
                      isFilled: true,
                      label: 'Greeting Others',
                      q2: 'WA',
                    ),
                    renderOptionRow(
                      label: 'Silence Game',
                      q2: 'WI',
                    ),
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
                      title: '3. Language',
                    ),
                    renderSubtitleRow(
                      title: '',
                    ),
                    renderOptionRow(
                      isFilled: true,
                      label: 'Opposites',
                      q2: '-',
                    ),
                    renderOptionRow(
                      label: 'Clasification: Rooms & Furnitures',
                      q2: '-',
                    ),
                    renderOptionRow(
                      isFilled: true,
                      label: 'Sand Paper Letters',
                      q2: 'WA',
                    ),
                    renderOptionRow(
                      label: 'Metal Insets',
                      q2: 'WA',
                    ),
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
                      title: '4. Mathematics',
                    ),
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
                      title: '5. Culture',
                    ),
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
                      title: '6. Social & Emotional Growth',
                    ),
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
                      title: '7. Learning Style',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              '22 December, 2022',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: const [
                      Text(
                        'Poppy Morina, S.Pd',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Principal',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    children: const [
                      Text(
                        'Ms. Annisa Oktarianda, S. Psi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Class Teacher',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget renderSubtitleRow({
    String title = '',
  }) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              'Q1',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              'Q2',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              'Q3',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              'Q4',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderOptionRow({
    required String label,
    String q1 = '',
    String q2 = '',
    String q3 = '',
    String q4 = '',
    bool isFilled = false,
  }) {
    return Container(
      color: isFilled ? Colors.grey.withOpacity(0.1) : null,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: Text(label),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                q1,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                q2,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                q3,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                q4,
                textAlign: TextAlign.center,
              ),
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
