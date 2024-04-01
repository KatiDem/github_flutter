import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:github_api/presentation/utils/colors.dart';
import 'package:github_api/presentation/utils/icons.dart';
import 'package:github_api/presentation/utils/typography.dart';

class SearchCard extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onFavoritePressed;

  const SearchCard({
    Key? key,
    required this.title,
    required this.onFavoritePressed,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.layerColor,
      ),
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: const AppTextStyle.body(),
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          InkWell(
            onTap: onFavoritePressed,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset(
                AppIcons.star,
                color: isActive ? AppColors.primaryAccentColor : AppColors.placeholderTextColor,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
