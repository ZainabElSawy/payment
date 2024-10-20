import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/thank_you_view_body.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: Transform.translate(
            offset: const Offset(0, -18), child: const ThankYouViewBody()),
      ),
    );
  }
}
