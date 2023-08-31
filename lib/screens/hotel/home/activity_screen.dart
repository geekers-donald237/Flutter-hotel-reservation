import 'package:find_hotel/gen/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/activity_model.dart';
import '../../../widgets/app_text.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Activity> activities = Activity.activities;

    List<String> _titlesList = [
      AppLocalizations.of(context)!.find_the_best_deal,
      AppLocalizations.of(context)!.the_place_you_need_is_here,
      AppLocalizations.of(context)!.a_place_to_visite,
      AppLocalizations.of(context)!.other_destination,
    ];
    List<String> _subtitlesList = [
      AppLocalizations.of(context)!.the_best_deal_for_your_holidays,
      AppLocalizations.of(context)!.pas_be_deplace,
      AppLocalizations.of(context)!.util_app,
      AppLocalizations.of(context)!.destination_place,
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          _ActivitiesMasonryGrid(
            width: width,
            activities: activities,
            activitySubTitle: _titlesList,
            activityTitle: _subtitlesList,
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
    required this.activityTitle,
    required this.activitySubTitle,
  }) : super(key: key);

  final List<double> masonryCardHeights;
  final double width;
  final List<Activity> activities;
  final List<String> activityTitle;
  final List<String> activitySubTitle;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: 4,
      crossAxisCount: 2,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      itemBuilder: (context, index) {
        Activity activity = activities[index];
        return _buildActivityCard(context, activity, index,
            activityTitle[index], activitySubTitle[index]);
      },
    );
  }

  Widget _buildActivityCard(
    BuildContext context,
    Activity activity,
    int index,
    String title,
    String subtitle,
  ) {
    return GestureDetector(
      onTap: () {
        print('ok');
      },
      child: SizedBox(
        width: 220,
        child: Card(
          elevation: 2,
          shadowColor: kblack,
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
                  height: masonryCardHeights[index % 1],
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
                margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: AppText.medium(
                  title,
                  textAlign: TextAlign.left,
                  maxLine: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
                  child: AppText.small(
                    subtitle,
                    textAlign: TextAlign.left,
                    maxLine: 2,
                    textOverflow: TextOverflow.ellipsis,
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
