import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/config/locale/app_localizations.dart';
import 'package:trend/config/locale/localization_cubit/localization_cubit.dart';
import 'package:trend/config/routes/app_routes.dart';
import 'package:trend/core/resources/assets_manager.dart';
import 'package:trend/core/resources/color_manager.dart';
import 'package:trend/core/utils/app_divider.dart';
import 'package:trend/core/utils/dialog_utils.dart';
import 'package:trend/core/utils/modal_sheet_utils.dart';
import 'package:trend/features/settings/presentation/widgets/settings_tile.dart';

import '../../../../core/bloc/theme_cubit/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings".hardcoded),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingsTileWidget(
              title: "Language".hardcoded,
              onTap: () {
                _languageModal(context);
              },
              iconIAssetUrl: ImgAssets.languageIconSVG,
            ),
            SettingsTileWidget(
              title: "Theme".hardcoded,
              onTap: () {
                _themeModal(context);
              },
              iconIAssetUrl: ImgAssets.themeIconSVG,
            ),
            // SettingsTileWidget(
            //   title: "Private account".hardcoded,
            //   onTap: () {
            //
            //   },
            //   titleColor: kRedColor,
            // ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 4.sp),
              child: SettingsTileWidget(
                title: "Logout".hardcoded,
                onTap: () async {
                  final result = await DialogUtils(context).showConfirmDialog(
                      titleText: "Logout confrim".hardcoded,
                      contentText: "Do you want to logout ?".hardcoded,
                      submitButtonText: "Logout".hardcoded,
                      submitButtonColor: kRedColor);

                  if (result != null && result is bool && result) {
                    logout();
                  }
                },
                titleColor: kRedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _themeModal(BuildContext context) {
    ModalSheetUtils(context).showCustomModalSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingsTileWidget(
            title: "Light Theme".hardcoded,
            onTap: () {
              context.read<ThemeCubit>().changeMode(ThemeMode.light);
            },
            iconIAssetUrl: ImgAssets.lightThemeIconSVG,
            showTrailing: false,
          ),
          const AppDivider(),
          SettingsTileWidget(
            title: "Dark Theme".hardcoded,
            showTrailing: false,
            onTap: () {
              context.read<ThemeCubit>().changeMode(ThemeMode.dark);
            },
            iconIAssetUrl: ImgAssets.themeIconSVG,
          ),
          const AppDivider(),
        ],
      ),
      title: 'Theme'.hardcoded,
      height: MediaQuery.sizeOf(context).height * .3.sp,
      assetImageUrl: ImgAssets.themeIconSVG,
    );
  }

  void _languageModal(BuildContext context) {
    ModalSheetUtils(context).showCustomModalSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingsTileWidget(
            title: "Arabic".hardcoded,
            onTap: () {
              context
                  .read<LocalizationCubit>()
                  .changeLanguage(const Locale("ar"));
            },
            showTrailing: false,
          ),
          const AppDivider(),
          SettingsTileWidget(
            title: "English".hardcoded,
            showTrailing: false,
            onTap: () {
              context
                  .read<LocalizationCubit>()
                  .changeLanguage(const Locale("en"));
            },
          ),
          const AppDivider(),
        ],
      ),
      title: 'Theme'.hardcoded,
      height: MediaQuery.sizeOf(context).height * .3.sp,
      assetImageUrl: ImgAssets.languageIconSVG,
    );
  }
}
