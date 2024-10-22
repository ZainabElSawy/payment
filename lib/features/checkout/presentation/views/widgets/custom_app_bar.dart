import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
  });
  final String? title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Center(child: SvgPicture.asset("assets/images/Arrow.svg")),
      elevation: 0,
      title: Text(
        title ?? "",
        textAlign: TextAlign.center,
        style: Styles.textStyle25.copyWith(fontSize: 25),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
