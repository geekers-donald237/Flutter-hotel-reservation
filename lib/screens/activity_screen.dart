import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../gen/theme.dart';
import '../models/activity_model.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Activity> activities = Activity.activities;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          _ActivitiesMasonryGrid(
            width: width,
            activities: activities,
          ),
        ],
      ),
    );
  }
}

class _ActivitiesMasonryGrid extends StatelessWidget {
  const _ActivitiesMasonryGrid({
    Key? key,
    this.masonryCardHeights = const [200, 250, 300],
    required this.width,
    required this.activities,
  }) : super(key: key);

  final List<double> masonryCardHeights;
  final double width;
  final List<Activity> activities;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: 6,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) {
        Activity activity = activities[index];
        return _buildActivityCard(
          context,
          activity,
          index,
        );
      },
    );
  }

  Widget _buildActivityCard(
    BuildContext context,
    Activity activity,
    int index,
  ) {
    return SizedBox(
      width: 220,
      child: Card(
        elevation: 0.5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: '${activity.id}_${activity.title}',
              child: Container(
                height: masonryCardHeights[index % 2],
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(activity
                        .imagePath), // Utilise AssetImage au lieu de Image.asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              child: Text("Cards Title 1",
                  // style: titleTextStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
              margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: Text(
                    'items[index].subtitle',
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
