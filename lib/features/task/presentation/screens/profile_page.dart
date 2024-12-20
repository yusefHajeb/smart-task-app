import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_task/common_widgets/responsive_widgets_scrollable.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import 'package:smart_task/features/task/presentation/bloc/app_theme/app_theme_bloc.dart';

import '../bloc/localizations_cubit/localizations_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenterScrollable(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.white,
            ),
            child: SvgPicture.asset("assets/svg/logo.svg"),
          ),
          Divider(
            color: Colors.grey[600],
            height: 1,
            thickness: 0.2,
          ),
          Card(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Notification'.tr(context)),
                          const Icon(Icons.notification_important)
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey[600],
                      height: 1,
                      thickness: 0.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('language'.tr(context)),
                        DropdownButton<String>(
                          underline: Container(),
                          value: Localizations.localeOf(context).languageCode,
                          icon: const Icon(Icons.language),
                          onChanged: (String? newValue) async {
                            if (newValue != null) {
                              context
                                  .read<LocalizationsCubit>()
                                  .changeLanguage(newValue);
                            }
                          },
                          items: const [
                            DropdownMenuItem<String>(
                              value: 'en',
                              child: Text('English'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'ar',
                              child: Text('العربية'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'ru',
                              child: Text('Russia'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey[600],
                      height: 1,
                      thickness: 0.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Theme'.tr(context)),
                        BlocBuilder<AppThemeBloc, AppThemeState>(
                          builder: (context, state) {
                            return IconButton(
                              onPressed: () {
                                context
                                    .read<AppThemeBloc>()
                                    .add(AppThemeChanged(
                                      themeMode:
                                          state.themeMode == ThemeMode.dark
                                              ? ThemeMode.light
                                              : ThemeMode.dark,
                                    ));
                              },
                              icon: Icon(
                                state.themeMode == ThemeMode.dark
                                    ? Icons.light_mode_outlined
                                    : Icons.dark_mode_outlined,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Wrap(
                        children: [Text('© 2024 Smart Task By Yousef Hageb')],
                      ),
                    )
                  ],
                )),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
