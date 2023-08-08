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

  Card _buildActivityCard(
    BuildContext context,
    Activity activity,
    int index,
  ) {
    return Card(
      elevation: 0.4,
      shadowColor: kblack,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Column(
          children: [
            Hero(
              tag: '${activity.id}_${activity.title}',
              child: Container(
                height: masonryCardHeights[index % 2],
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  border: Border(
                    bottom: BorderSide(color: kgrey),
                  ),
                  image: DecorationImage(
                    image: AssetImage(activity
                        .imagePath), // Utilise AssetImage au lieu de Image.asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Cards Title 1",
              style: TextStyle(
                  fontFamily: 'worksans',
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Text(
              MyStringsSample.card_text,
              maxLines: 2,
              style: MyTextSample.subhead(context)!.copyWith(
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
