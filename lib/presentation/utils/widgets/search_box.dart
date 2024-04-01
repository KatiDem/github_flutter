import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_api/presentation/utils/colors.dart';
import 'package:github_api/presentation/utils/icons.dart';

class SearchBox extends StatefulWidget {
  final bool isDisabled;
  final Function(String text) onSearch;
  final TextEditingController? controller;

  const SearchBox({
    Key? key,
    this.controller,
    this.isDisabled = false,
    required this.onSearch,
  }) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> with WidgetsBindingObserver {
  TextEditingController? _controller;
  bool _isFocused = false;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isDisabled ? AppColors.layerColor : _getBackgroundColor(),
          borderRadius: BorderRadius.circular(30),
          border: _getInputBorder(),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isFocused = true;
                });
                _focusNode.requestFocus();
              },
              child: SvgPicture.asset(
                AppIcons.search,
                width: 24,
                height: 24,
                color: _getIconColor(),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.done,
                onEditingComplete: () => _focusNode.unfocus(),
                enabled: !widget.isDisabled,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: AppColors.placeholderTextColor),
                  fillColor: Colors.transparent,
                  filled: true,
                ),
                onTap: () {
                  setState(() {
                    _isFocused = true;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _isFocused = true;
                  });
                },
                onSubmitted: (value) async {
                  setState(() {
                    _isFocused = false;
                  });
                  widget.onSearch(_controller?.text ?? '');
                  _focusNode.unfocus();
                },
                focusNode: _focusNode,
              ),
            ),
            if (!widget.isDisabled && (_isFocused ||(_controller?.text.isNotEmpty ?? false)))
              GestureDetector(
                onTap: () {
                  _focusNode.unfocus();
                  _controller?.clear();
                  setState(() {
                    _isFocused = false;
                  });
                },
                child: SvgPicture.asset(
                  AppIcons.close,
                  color: AppColors.primaryAccentColor,
                  width: 20,
                  height: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getIconColor() {
    return widget.isDisabled ? AppColors.placeholderTextColor : AppColors.primaryAccentColor;
  }

  Color _getBackgroundColor() {
    if (_isFocused && !widget.isDisabled) {
      return AppColors.secondaryAccentColor;
    } else {
      return AppColors.layerColor;
    }
  }

  BoxBorder? _getInputBorder() {
    if (_isFocused && !widget.isDisabled) {
      return const Border.fromBorderSide(
        BorderSide(
          width: 2,
          color: AppColors.primaryAccentColor,
        ),
      );
    } else {
      return null;
    }
  }
}
