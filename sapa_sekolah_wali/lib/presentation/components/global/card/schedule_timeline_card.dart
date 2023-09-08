import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ScheduleTimelineCard extends StatelessWidget {
  const ScheduleTimelineCard({Key? key, this.isActive = false})
      : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      axis: TimelineAxis.vertical,
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      indicatorStyle: IndicatorStyle(
        indicator: Container(),
      ),
      afterLineStyle: const LineStyle(
        color: Color(0xffFAF9F9),
        thickness: 2,
      ),
      beforeLineStyle: const LineStyle(
        color: Color(0xffFAF9F9),
        thickness: 2,
      ),
      endChild: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xff2196F3) : const Color(0xffF6F6F5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Matematika',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Bab 1 : Introduction',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  CupertinoIcons.location_solid,
                  color: isActive ? Colors.white : Colors.grey,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  'Ruang 123',
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: CachedNetworkImageProvider(
                          'https://d3t3ozftmdmh3i.cloudfront.net/production/podcast_uploaded_nologo/1428780/1428780-1601846607334-e07cc973804e5.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Ust Abdul',
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      startChild: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text('07:00',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          Text('09:00',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey)),
        ],
      ),
    );
  }
}
