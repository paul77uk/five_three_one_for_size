import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/landing_page.dart';

void main() => runApp(
      GetMaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
