import 'package:flutter/material.dart';

class DailyReportPage extends StatelessWidget {
  const DailyReportPage({super.key});

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
          'Laporan Harian',
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
                      color: const Color(0xff9C27B0),
                      title: 'Work Habits',
                    ),
                    renderSubTitle(
                      title: 'Complete Work On Time',
                    ),
                    renderOption(
                      label: 'Always',
                      isChecked: true,
                    ),
                    renderOption(
                      label: 'Most of The Time',
                      isChecked: false,
                    ),
                    renderOption(
                      label: 'Sometimes',
                      isChecked: false,
                    ),
                    renderOption(
                      label: 'Hard to miss Recess To Complete Complete',
                      isChecked: false,
                    ),
                    renderSubTitle(
                      title: 'Quality Of Work',
                    ),
                    renderOption(
                      label: 'Excellent',
                      isChecked: false,
                    ),
                    renderOption(
                      label: 'Good',
                      isChecked: true,
                    ),
                    renderOption(
                      label: 'Satisfactory',
                      isChecked: false,
                    ),
                    renderOption(
                      label: 'Needs Improvement',
                      isChecked: false,
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
                      color: const Color(0xff2196F3),
                      title: 'Needs To Work On',
                    ),
                    renderOption(
                      label: 'Reading',
                      isChecked: true,
                    ),
                    renderOption(
                      label: 'Spelling',
                      isChecked: false,
                    ),
                    renderOption(
                      label: 'Writing',
                      isChecked: false,
                    ),
                    renderOption(
                      label: 'Math',
                      isChecked: false,
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
                      color: const Color(0xff4CAF50),
                      title: 'Behavior',
                    ),
                    renderSubTitle(
                      title: 'Behavior At School',
                    ),
                    renderOption(
                      label: 'Excellent',
                      isChecked: false,
                    ),
                    renderOption(
                      label: 'Good',
                      isChecked: false,
                    ),
                    renderOption(
                      label: 'Satisfactory',
                      isChecked: false,
                    ),
                    renderOption(
                      label: 'Needs Improvement',
                      isChecked: true,
                    ),
                    renderSubTitle(
                      title: 'Areas For Improvement',
                    ),
                    renderOption(
                      label: 'Talking',
                      isChecked: true,
                    ),
                    renderOption(
                      label: 'Listening Skill',
                      isChecked: true,
                    ),
                    renderOption(
                      label: 'Following Instructions',
                      isChecked: true,
                    ),
                    renderOption(
                      label: 'Staying on Task',
                      isChecked: true,
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
                      color: const Color(0xff607D8B),
                      title: 'Teacher Comments',
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                      ),
                    )
                  ],
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

  Container renderSubTitle({
    required String title,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      color: Colors.grey.withOpacity(0.1),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Container renderOption({
    required String label,
    required bool isChecked,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Row(
        children: [
          Icon(
            isChecked ? Icons.check_box : Icons.check_box_outline_blank,
            color: const Color(0xff4CAF50),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
