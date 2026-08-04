import 'package:bariq/core/constants/app_assets.dart';
import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:flutter/material.dart';

class BariqBrandMark extends StatelessWidget {
  const BariqBrandMark({this.width, super.key});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.brandIcon,
      width: width ?? AppSizes.brandMarkWidth,
      semanticLabel: AppStrings.brandSemanticLabel,
    );
  }
}
