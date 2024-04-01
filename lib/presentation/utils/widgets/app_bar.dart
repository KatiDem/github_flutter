import 'package:flutter/material.dart';
import 'package:github_api/presentation/utils/colors.dart';

import '../typography.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onActionPressed;
  final String? title;
  final Widget? leading;
  final Widget? action;

  const CustomAppBar({
    Key? key,
    this.onActionPressed,
    this.title,
    this.leading,
    this.action,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading ?? const SizedBox(width: 44),
          Expanded(
            child: Center(
              child: Text(
                title ?? '',
                style: const AppTextStyle.header(),
              ),
            ),
          ),
        ],
      ),
      actions: [
        action ?? const SizedBox(width: 44),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          height: 2,
          color: AppColors.layerColor,
        ),
      ),
    );
  }
}
