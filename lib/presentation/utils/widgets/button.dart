import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_api/presentation/utils/colors.dart';

class AppIconButton extends StatefulWidget {
  final String icon;
  final Function() onPressed;
  final bool isEnabled;

  const AppIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: widget.isEnabled ? widget.onPressed : null,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.isEnabled
              ? (_isPressed ? AppColors.secondaryAccentColor : AppColors.primaryAccentColor)
              : AppColors.layerColor,
          border: !widget.isEnabled ? Border.all(width: 2, color: AppColors.placeholderTextColor) : null,
        ),
        child:Transform.scale(
          scale: 20 / 42,
          child: SvgPicture.asset(
            widget.icon,
            color: widget.isEnabled ? AppColors.mainBackgroundColor : AppColors.placeholderTextColor,
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
}
