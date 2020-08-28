import 'package:flutter/material.dart';

import '../widgets/launch_url_list_tile.dart';
import '../widgets/route_tile.dart';
import 'program_title_page.dart';
import 'rep_max_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '5/3/1 For Size',
          style: TextStyle(color: Colors.grey[300]),
        ),
      ),
      body: ListView(
        children: <Widget>[
          RouteTile(
            title: 'Rep Maxes',
            route: RepMaxPage(),
          ),

          RouteTile(
            title: 'Program Screen',
            route: ProgramTitlePage(),
          ),

          // RouteTile(
          //   title: 'Settings',
          //   route: SettingsPage(),
          // ),

          // RouteTile(
          //   title: 'Rep Max Page',
          //   route: RepMaxListPage(),
          // ),
          // RouteTile(
          //   title: 'Timer',
          //   route: TimerHomePage(),
          // ),
          // RouteTile(
          //   title: 'Exercises & Maxes',
          //   route: RepMaxPage(),
          // ),
          // RouteTile(
          //   title: 'Warm Up/ Mobility',
          //   route: WarmUpPage(),
          // ),
          // RouteTile(
          //   title: 'Deload/ 7th Week Protocol',
          //   route: DeloadPage(),
          // ),
          // // RouteTile(
          // //   title: 'Assistant Work',
          // //   route: AssistancePage(),
          // // ),
          // RouteTile(
          //   title: 'Training Programs',
          //   route: TrainingProgramsPage(),
          // ),
          // RouteTile(
          //   title: 'Conditioning',
          //   route: ConditioningPage(),
          // ),
          // RouteTile(
          //   title: 'Recovery',
          //   route: RecoveryPage(),
          // ),
          LaunchUrlListTile(
            title: 'Jim Wendler UGSS Presentation',
            url:
                'https://www.youtube.com/watch?v=u_Il5nOqLhY&list=PLbFxzzq99IUDeEwQSuXUTnDq3ytYSqRg4',
            icon: Icons.play_arrow,
          ),
          LaunchUrlListTile(
            title: 'Jim Wendler Sports Performance Summit 2018',
            url:
                'https://www.youtube.com/watch?v=N3g0LKUV8RM&list=PLbFxzzq99IUB5L1-VLNN2IdQgmVrGXjZS&index=1',
            icon: Icons.play_arrow,
          ),
          LaunchUrlListTile(
            title: 'Buy the books',
            url: 'https://jimwendler.com/collections/books-programs',
          ),
        ],
      ),
    );
  }
}
