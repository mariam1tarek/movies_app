import 'package:flutter/material.dart';

/// كاروسيل الأفاتار: الأفاتار اللي في النص كبير والجنب أصغر.
class AvatarPicker extends StatelessWidget {
  const AvatarPicker({
    super.key,
    required this.controller,
    required this.avatars,
    required this.onChanged,
    required this.onTap,
  });

  static const double _size = 120;

  final PageController controller;
  final List<String> avatars;
  final ValueChanged<int> onChanged;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size + 8,
      child: PageView.builder(
        controller: controller,
        itemCount: avatars.length,
        onPageChanged: onChanged,
        itemBuilder: (_, index) {
          return AnimatedBuilder(
            animation: controller,
            builder: (_, child) {
              double page = controller.initialPage.toDouble();
              if (controller.hasClients && controller.position.haveDimensions) {
                page = controller.page ?? page;
              }
              final scale = (1 - (page - index).abs() * 0.35).clamp(0.6, 1.0);
              return Center(child: Transform.scale(scale: scale, child: child));
            },
            child: GestureDetector(
              onTap: () => onTap(index),
              child: ClipOval(
                child: Image.asset(
                  avatars[index],
                  width: _size,
                  height: _size,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
