import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import 'package:smart_task/features/task/presentation/bloc/app_theme/app_theme_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/localizations_cubit/localizations_cubit.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool? isFirstPage;
  final Color backgroundColor;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    this.isFirstPage,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  image,
                  height: 200,
                ),
                AppSize.height32(),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                  textAlign: TextAlign.center,
                ),
                AppSize.height24(),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                        height: 1.5,
                      ),
                  textAlign: TextAlign.center,
                ),
                AppSize.height24(),
                if (isFirstPage != null && isFirstPage!)
                  Card(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('language'.tr(context)),
                                DropdownButton<String>(
                                  underline: Container(),
                                  value: Localizations.localeOf(context)
                                      .languageCode,
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
                                              themeMode: state.themeMode ==
                                                      ThemeMode.dark
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
                          ],
                        )),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
