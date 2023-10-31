import 'package:flutter/material.dart';

import '../../core/values/color.dart';

class MSwitch extends StatefulWidget {
  const MSwitch({
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inActiveColor,
    super.key,
  });

  final bool value;
  final Function(bool) onChanged;
  final Color? activeColor;
  final Color? inActiveColor;

  @override
  State<MSwitch> createState() => _MSwitchState();
}

class _MSwitchState extends State<MSwitch> {
  late bool _isChecked;

  @override
  void initState() {
    _isChecked = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
        widget.onChanged(_isChecked);
      },
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        alignment: _isChecked ? Alignment.centerRight : Alignment.centerLeft,
        width: 34,
        height: 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: _isChecked
              ? widget.activeColor ?? AppColors.secondaryColor
              : widget.inActiveColor ?? AppColors.hintColor,
        ),
        duration: const Duration(milliseconds: 200),
        child: Icon(
          size: 15,
          Icons.circle,
          color: _isChecked ? Colors.white : const Color(0xffd3d3d3),
        ),
      ),
    );
  }
}
