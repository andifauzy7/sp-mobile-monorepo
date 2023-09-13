import 'package:flutter/material.dart';
import 'package:sapa_sekolah_wali/model/child/child_model.dart';

class ChildCard extends StatelessWidget {
  const ChildCard({
    Key? key,
    this.childModel,
    this.onTap,
  }) : super(key: key);

  final ChildModel? childModel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: const Color(0xffe16cb3),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Center(
                child: Icon(Icons.people_alt, color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    childModel?.studentName ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text('Siswa')
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_rounded)
          ],
        ),
      ),
    );
  }
}
