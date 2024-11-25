import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_task/common_widgets/responsive_widgets_scrollable.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenterScrollable(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(50.r),
              color: Colors.white,
            ),
            child: SvgPicture.asset("assets/svg/welcome.svg"),
          ),
          const Divider(),
          const Card(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      children: [Text(''), Icon(Icons.notification_important)],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
